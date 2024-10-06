import 'dart:convert';

import 'package:client/core/failure/app_failure.dart';
import 'package:client/core/values/app_constants.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

import 'package:http/http.dart' as http;

class AuthRemoteRepo {
  Future<Either<AppFailure, UserModel>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.serverBaseURL}/auth/signin"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode != 200) {
        return Left(AppFailure(message: jsonDecode(response.body)["detail"]));
      }

      final user = jsonDecode(response.body)["user"] as Map<String, dynamic>;
      return Right(
        UserModel.fromMap(user).copyWith(
          token: jsonDecode(response.body)["token"],
        ),
      );
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.serverBaseURL}/auth/signup"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode != 201) {
        return Left(AppFailure(message: jsonDecode(response.body)["detail"]));
      }

      final user = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(UserModel.fromMap(user));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUser({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.serverBaseURL}/auth/"),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": token,
        },
      );

      if (response.statusCode != 200) {
        return Left(AppFailure(message: jsonDecode(response.body)["detail"]));
      }

      final user = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(UserModel.fromMap(user).copyWith(token: token));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
