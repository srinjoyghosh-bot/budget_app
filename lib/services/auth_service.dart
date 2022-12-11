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
          'token': result.data['token'],
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

  Future<User?> getProfile(String token) async {
    try {
      final result = await dio.get('${BASE_URL}auth/profile',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
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
      String token, String oldPw, String newPw, String confirmPw) async {
    try {
      final result = await dio.put('${BASE_URL}auth/change-password',
          data: {
            'oldPassword': oldPw,
            'newPassword': newPw,
            'confirmPassword': confirmPw,
            // 'userId': id
          },
          options: Options(contentType: 'application/json', headers: {
            'Authorization': 'Bearer $token',
          }));
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

  Future<Map<String, dynamic>> changeBudget(String token, String budget) async {
    try {
      final result = await dio.put('${BASE_URL}auth/update-budget',
          data: {'budget': budget},
          options: Options(contentType: 'application/json', headers: {
            'Authorization': 'Bearer $token',
          }));
      // print(result.data);
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

  Future<Map<String, dynamic>> editProfile(
      String token, String email, String username) async {
    try {
      final result = await dio.put('${BASE_URL}auth/edit-profile',
          data: {
            'name': username,
            'email': email,
          },
          options: Options(contentType: 'application/json', headers: {
            'Authorization': 'Bearer $token',
          }));
      if (result.statusCode == 200) {
        return {
          'status': 200,
          'message': 'Profile updated!',
        };
      }
      return {
        'status': result.statusCode,
        'message': (result.data != null && result.data['data'] is List)
            ? result.data['data'][0]['msg']
            : result.data['message'],
      };
    } on Exception catch (e) {
      return {
        'status': 500,
        'message': "Some error occurred. Try again",
      };
    }
  }
}
