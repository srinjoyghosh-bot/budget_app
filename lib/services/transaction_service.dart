import 'dart:convert';

import 'package:budget_app/constants/constants.dart';
import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/models/transaction.dart';
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
}
