import 'package:budget_app/constants/constants.dart';
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
}
