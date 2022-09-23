import 'dart:convert';

import 'package:budget_app/constants/constants.dart';
import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/models/transaction_history.dart';
import 'package:budget_app/models/transaction_stats.dart';
import 'package:budget_app/util/time.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TransactionService {
  var dio = Dio();

  Future<List<Transaction>> getDatedTransactions(
      DateTime date, String id) async {
    try {
      final result = await dio.get('${BASE_URL}transactions/get/$id',
          options: Options(headers: {'Content-Type': 'application/json'}),
          queryParameters: {'date': getFormattedTime(date)});
      // print(getFormattedTime(date));
      if (result.statusCode == 200) {
        return List<Transaction>.from(result.data['transactions']
            .map((transaction) => Transaction.fromJson(transaction)));
      } else {
        return [];
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>> create(String title, String amount,
      TransactionType type, TransactionCategory category, String id) async {
    try {
      final result = await dio.post('${BASE_URL}transactions/add',
          data: jsonEncode({
            'title': title,
            'amount': amount,
            'type': type.name,
            'category': category.name,
            'userId': id
          }),
          options: Options(contentType: 'application/json'));
      if (result.statusCode == 200) {
        final transaction = Transaction.fromJson(result.data['result']);
        return {
          'status': 200,
          'message': 'Transaction created!',
          'transaction': transaction,
        };
      }
      return {
        'status': result.statusCode,
        'message': result.data['message'] ?? 'Some error occurred. Try again'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occured',
      };
    }
  }

  Future<Map<String, dynamic>> getStats(String id) async {
    try {
      final result = await dio.get('${BASE_URL}transactions/stats/$id',
          options: Options(contentType: 'application/json'));
      if (result.statusCode == 200) {
        final stats = TransactionStats.fromJson(result.data);
        return {
          'status': 200,
          'stats': stats,
        };
      } else {
        return {
          'status': result.statusCode,
          'message': 'Could not fetch stats',
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Could not fetch stats',
      };
    }
  }

  Future<Map<String, dynamic>> history(String id) async {
    List<TransactionHistory> history = [];
    try {
      final result = await dio.get(
        '${BASE_URL}transaction/history/$id',
        options: Options(contentType: 'application/json'),
      );
      if (result.statusCode == 200) {
        if (result.data['data'] != null) {
          // final data = result.data['data'];
          for (MapEntry entry in result.data['data'].entries) {
            String month = entry.key
                .toString()
                .substring(0, entry.key.toString().indexOf('_'));
            String year = entry.key
                .toString()
                .substring(entry.key.toString().indexOf('_') + 1);
            double total = 0,
                food = 0,
                clothes = 0,
                travel = 0,
                miscellaneous = 0;

            for (Map<String, dynamic> item in entry.value) {
              final transaction = Transaction.fromJson(item);
              if (transaction.type == TransactionType.spent) {
                total += transaction.amount;
              } else {
                total -= transaction.amount;
              }
              switch (transaction.category) {
                case TransactionCategory.food:
                  if (transaction.type == TransactionType.spent) {
                    food += transaction.amount;
                  } else {
                    food -= transaction.amount;
                  }
                  break;
                case TransactionCategory.clothes:
                  if (transaction.type == TransactionType.spent) {
                    clothes += transaction.amount;
                  } else {
                    clothes -= transaction.amount;
                  }
                  break;
                case TransactionCategory.travel:
                  if (transaction.type == TransactionType.spent) {
                    travel += transaction.amount;
                  } else {
                    travel -= transaction.amount;
                  }
                  break;
                case TransactionCategory.miscellaneous:
                  if (transaction.type == TransactionType.spent) {
                    miscellaneous += transaction.amount;
                  } else {
                    miscellaneous -= transaction.amount;
                  }
                  break;
              }
              history.add(TransactionHistory(
                  month: month,
                  year: year,
                  total: total,
                  food: food,
                  clothes: clothes,
                  travel: travel,
                  miscellaneous: miscellaneous));
            }
          }
        }
        return {
          'status': 200,
          'history': history,
        };
      } else {
        return {
          'status': result.statusCode,
          'message': result.data['message'] ?? 'Some error occurred. Try again'
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred. Try again'};
    }
  }
}
