import 'dart:convert';
import 'dart:io';

import 'package:budget_app/constants/constants.dart';
import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/models/transaction_history.dart';
import 'package:budget_app/models/transaction_stats.dart';
import 'package:budget_app/util/time.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  // var dio = Dio();

  Uri getUri(String endpoint) {
    return Uri.parse('${BASE_URL}transactions/$endpoint');
  }

  Future<List<Transaction>> getDatedTransactions(
      DateTime date, String token) async {
    try {
      // final result = await dio.get('${BASE_URL}transactions/get',
      //     options: Options(headers: {
      //       'Content-Type': 'application/json',
      //       'Authorization': 'Bearer $token'
      //     }),
      //     queryParameters: {'date': getFormattedTime(date)});
      final result = await http.get(
          getUri('get')
              .replace(queryParameters: {'date': getFormattedTime(date)}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      // print(getFormattedTime(date));
      if (result.statusCode == 200) {
        return List<Transaction>.from(jsonDecode(result.body)['transactions']
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
      TransactionType type, TransactionCategory category, String token) async {
    try {
      // final result = await dio.post('${BASE_URL}transactions/add',
      //     data: jsonEncode({
      //       'title': title,
      //       'amount': amount,
      //       'type': type.name,
      //       'category': category.name,
      //       // 'userId': id
      //     }),
      //     options: Options(
      //         contentType: 'application/json',
      //         headers: {'Authorization': 'Bearer $token'}));
      final result = await http.post(
        getUri('add'),
        body: jsonEncode({
          'title': title,
          'amount': amount,
          'type': type.name,
          'category': category.name,
          // 'userId': id
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      if (result.statusCode == 200) {
        final transaction =
            Transaction.fromJson(jsonDecode(result.body)['result']);
        return {
          'status': 200,
          'message': 'Transaction created!',
          'transaction': transaction,
        };
      }
      return {
        'status': result.statusCode,
        'message': jsonDecode(result.body)['message'] ??
            'Some error occurred. Try again'
      };
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occured',
      };
    }
  }

  Future<Map<String, dynamic>> getStats(String token) async {
    try {
      // final result = await dio.get('${BASE_URL}transactions/stats',
      //     options: Options(
      //         contentType: 'application/json',
      //         headers: {'Authorization': 'Bearer $token'}));
      final result = await http.get(
        getUri('stats'),
        headers: {
          'Authorization': 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (result.statusCode == 200) {
        final stats = TransactionStats.fromJson(jsonDecode(result.body));
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

  Future<Map<String, dynamic>> history(String token) async {
    List<TransactionHistory> history = [];
    try {
      // final result = await dio.get(
      //   '${BASE_URL}transactions/history',
      //   options: Options(contentType: 'application/json', headers: {
      //     'Authorization': 'Bearer $token',
      //   }),
      // );
      final result = await http.get(
        getUri('history'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = jsonDecode(result.body);
      if (result.statusCode == 200) {
        if (data['data'] != null) {
          // final data = result.data['data'];
          for (MapEntry entry in data['data'].entries) {
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
        return {
          'status': 200,
          'history': history,
        };
      } else {
        return {
          'status': result.statusCode,
          'message': data['message'] ?? 'Some error occurred. Try again'
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred. Try again'};
    }
  }
}
