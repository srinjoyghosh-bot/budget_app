import 'dart:convert';

import 'package:budget_app/constants/constants.dart';
import 'package:budget_app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthService {
  var dio = Dio();

  Future<bool> signupUser(
      String email, String password, String username, String budget) async {
    try {
      // print('${BASE_URL}auth/signup');
      final result = await dio.put('${BASE_URL}auth/signup',
          data: jsonEncode({
            'email': email,
            'password': password,
            'username': username,
            'budget': budget,
          }),
          options: Options(headers: {'Content-Type': 'application/json'}));
      // print(result.statusCode!);
      if (result.statusCode! == 201) {
        // print(result.data);
        return true;
      } else {
        // print(result.statusCode!);
        return false;
      }
    } on Exception catch (e) {
      // print('error');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final result = await dio.post('${BASE_URL}auth/login', data: {
        'email': email,
        'password': password,
      });
      if (result.statusCode == 200) {
        print(result.data);
        return {
          'status': 200,
          'userId': result.data['userId'],
        };
      } else {
        return {
          'status': result.statusCode,
          'message':
              result.data['message'] ?? 'Some error occurred. Please try again',
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occurred. Please try again',
      };
    }
  }

  Future<User?> getProfile(String id) async {
    try {
      final result = await dio.get('${BASE_URL}auth/profile/$id');
      if (result.statusCode == 200) {
        final user = User.fromJson(result.data['user']);
        return user;
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String id, String oldPw, String newPw, String confirmPw) async {
    try {
      final result = await dio.post('${BASE_URL}auth/change-password',
          data: {
            'oldPassword': oldPw,
            'newPassword': newPw,
            'confirmPassword': confirmPw,
            'userId': id
          },
          options: Options(contentType: 'application/json'));
      if (result.statusCode == 200) {
        return {
          'status': 200,
          'message': 'Password Updated!',
        };
      } else {
        return {
          'status': result.statusCode,
          'message': result.data['message'] ?? 'Some error occurred',
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred'};
    }
  }

  Future<Map<String, dynamic>> changeBudget(String id, String budget) async {
    try {
      final result = await dio.post('${BASE_URL}auth/update-budget',
          data: {'budget': budget, 'userId': id},
          options: Options(contentType: 'application/json'));
      print(result.data);
      if (result.statusCode == 200) {
        return {
          'status': 200,
          'message': 'Budget Updated!',
        };
      } else {
        return {
          'status': result.statusCode,
          'message': result.data['message'] ?? 'Some error occurred',
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {
        'status': 500,
        'message': 'Some error occurred',
      };
    }
  }
}
