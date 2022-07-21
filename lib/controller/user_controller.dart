import 'package:digitalcrop/models/user_model.dart';
import 'package:digitalcrop/services/auth_service.dart';
import 'package:digitalcrop/services/database_service.dart';
import 'package:digitalcrop/widgets/toast.dart';
import 'package:flutter/material.dart';

class UserController {

  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  Future<User?> getCurrentUser() async {
    User? user = await _authService.currentUser;
    return user;
  }

  Future<bool> signUp(String email, String password, String name) async {
    User? user = await _authService.signUp(email, password);
    if (user != null){
      user.name = name;
      await _databaseService.createUser(user);
      ToastBar(text: 'User successfully registered!', color: Colors.green).show();
      return true;
    }

    return false;
  }

  Future<bool> signIn(String email, String password) async {
    User? user = await _authService.signIn(email, password);
    return user != null;
  }

  Future<bool> forgetPassword(String email) async {
    return await _authService.forgetPassword(email);
  }

}