import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class AuthService with ChangeNotifier {
  Box<UserModel>? _userBox;
  static const String _loggedInKey = 'isLoggedIn';

  Future<void> openBox() async {
    _userBox = await Hive.openBox('users');
  }

  Future<bool> registerUser(UserModel user) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.add(user);
    notifyListeners();
    print("success");
    return true;
  }

  Future<UserModel?> loginUser(String name, String password) async {
    if (_userBox == null) {
      await openBox();
    }
    for (var user in _userBox!.values) {
      if (user.name == name && user.password == password) {
        await setLoggedInState(true);
        return user;
      }
    }
    return null;
  }

  // indicate user is already login
  Future<void> setLoggedInState(bool isLoggedIn) async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.setBool(_loggedInKey, isLoggedIn);
  }

  // check user is already login or not
  Future<bool> isUserLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_loggedInKey) ?? false;
  }
}

Future<UserModel> getUserData() async {
  final userBox = await Hive.openBox<UserModel>('users');
  final user = userBox.getAt(0);

  return user!;
}
