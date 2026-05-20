import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/user.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}

class AuthService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  Future<int> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim().toLowerCase();
    if (!isValidEmail(trimmedEmail)) {
      throw const AuthException('Email không hợp lệ');
    }

    try {
      final existingUser = await _databaseHelper.findUserByEmail(trimmedEmail);
      if (existingUser != null) {
        throw const AuthException('Email đã được đăng ký');
      }

      final user = User(
        id: null,
        name: name.trim(),
        email: trimmedEmail,
        password: password,
      );

      return _databaseHelper.insertUser(user.toInsertMap());
    } on AuthException {
      rethrow;
    } on DatabaseException catch (error) {
      if (error.isUniqueConstraintError()) {
        throw const AuthException('Email đã được đăng ký');
      }
      debugPrint('Database register error: $error');
      throw const AuthException('Không thể lưu tài khoản vào database');
    } on MissingPluginException catch (error) {
      debugPrint('SQLite plugin error: $error');
      throw const AuthException(
        'SQLite không chạy được trên Web. Hãy chạy Android Emulator hoặc Windows app đã cài sqflite_common_ffi.',
      );
    } catch (error) {
      debugPrint('Register error: $error');
      throw const AuthException('Không thể lưu tài khoản');
    }
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim().toLowerCase();
    if (!isValidEmail(trimmedEmail)) {
      throw const AuthException('Email không hợp lệ');
    }

    final result = await _databaseHelper.loginUser(
      trimmedEmail,
      password,
    );

    if (result == null) return null;
    return User.fromMap(result);
  }
}
