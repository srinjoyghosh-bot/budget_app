import 'dart:convert';

import 'package:budget_app/constants/constants.dart';
import 'package:budget_app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var dio = Dio();

  Uri getUri(String endpoint) {
    return Uri.parse('${BASE_URL}auth/$endpoint');
  }

  Future<Map<String, dynamic>> signupUser(
      String email, String password, String username, String budget) async {
    try {
      // final result = await dio.put('${BASE_URL}auth/signup',
      //     data: jsonEncode({
      //       'email': email,
      //       'password': password,
      //       'username': username,
      //       'budget': budget,
      //     }),
      //     options: Options(headers: {'Content-Type': 'application/json'}));
      final result = await http.put(getUri('signup'),
          body: jsonEncode({
            'email': email,
            'password': password,
            'username': username,
            'budget': budget,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      // print(result.statusCode!);
      if (result.statusCode == 201) {
        // print(result.data);
        return {'result': true, 'message': 'Account created!'};
      } else {
        // print(result.statusCode!);
        final resultBody = jsonDecode(result.body);
        return {
          'result': false,
          'message': (resultBody['data'] != null && resultBody['data'] is List)
              ? resultBody['data'][0]['msg']
              : resultBody['message']
        };
      }
    } on Exception catch (e) {
      // print('error');
      debugPrint(e.toString());
      return {
        'result': false,
        'message': 'Some error occurred. Please try again'
      };
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      // final result = await dio.post('${BASE_URL}auth/login', data: {
      //   'email': email,
      //   'password': password,
      // });
      final result = await http.post(getUri('login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {'Content-Type': 'application/json'});
      final data = jsonDecode(result.body);
      if (result.statusCode == 200) {
        // print(result.data);

        return {
          'status': 200,
          'userId': data['userId'],
          'token': data['token'],
        };
      } else {
        return {
          'status': result.statusCode,
          'message': data['message'] ?? 'Some error occurred. Please try again',
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
      // final result = await dio.get('${BASE_URL}auth/profile',
      //     options: Options(headers: {
      //       'Authorization': 'Bearer $token',
      //     }));
      final result = await http.get(getUri('profile'), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (result.statusCode == 200) {
        final user = User.fromJson(jsonDecode(result.body)['user']);
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
      // final result = await dio.put('${BASE_URL}auth/change-password',
      //     data: {
      //       'oldPassword': oldPw,
      //       'newPassword': newPw,
      //       'confirmPassword': confirmPw,
      //       // 'userId': id
      //     },
      //     options: Options(contentType: 'application/json', headers: {
      //       'Authorization': 'Bearer $token',
      //     }));

      final result = await http.put(
        Uri.parse('${BASE_URL}auth/change-password'),
        body: jsonEncode({
          'oldPassword': oldPw,
          'newPassword': newPw,
          'confirmPassword': confirmPw,
          // 'userId': id
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
      );
      debugPrint(result.body);
      if (result.statusCode == 200) {
        return {
          'status': 200,
          'message': 'Password Updated!',
        };
      } else {
        return {
          'status': result.statusCode,
          // 'message': result.data['message'] ?? 'Some error occurred',
          'message': jsonDecode(result.body)['message'] ?? 'Some error occurred'
        };
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return {'status': 500, 'message': 'Some error occurred'};
    }
  }

  Future<Map<String, dynamic>> changeBudget(String token, String budget) async {
    try {
      // final result = await dio.put('${BASE_URL}auth/update-budget',
      //     data: {'budget': budget},
      //     options: Options(contentType: 'application/json', headers: {
      //       'Authorization': 'Bearer $token',
      //     }));
      final result = await http.put(getUri('update-budget'),
          body: jsonEncode({'budget': budget}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      // print(result.data);
      if (result.statusCode == 200) {
        return {
          'status': 200,
          'message': 'Budget Updated!',
        };
      } else {
        return {
          'status': result.statusCode,
          'message':
              jsonDecode(result.body)['message'] ?? 'Some error occurred',
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
      // final result = await dio.put('${BASE_URL}auth/edit-profile',
      //     data: {
      //       'name': username,
      //       'email': email,
      //     },
      //     options: Options(contentType: 'application/json', headers: {
      //       'Authorization': 'Bearer $token',
      //     }));
      final result = await http.put(getUri('edit-profile'),
          body: jsonEncode({
            'name': username,
            'email': email,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (result.statusCode == 200) {
        return {
          'status': 200,
          'message': 'Profile updated!',
        };
      }
      final resultBody = jsonDecode(result.body);
      return {
        'status': result.statusCode,
        'message': (resultBody != null && resultBody['data'] is List)
            ? resultBody['data'][0]['msg']
            : resultBody['message'],
      };
    } on Exception catch (e) {
      return {
        'status': 500,
        'message': "Some error occurred. Try again",
      };
    }
  }
}
