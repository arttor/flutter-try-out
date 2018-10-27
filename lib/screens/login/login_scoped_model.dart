import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScopedModel extends Model {
  bool _isInit = false;
  String username;
  String password;

  LoginScopedModel();

  static LoginScopedModel of(BuildContext context) =>
      ScopedModel.of<LoginScopedModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    // update data for every subscriber, especially for the first one
    if (!_isInit) {
      _isInit = true;
      init();
    }
  }

  init() async {
    await Future.sync(() => Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('user');
    notifyListeners();
  }

  login() async {
    await Future.sync(() => Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', username);
    notifyListeners();
  }

  logout() async {
    await Future.sync(() =>
        Duration(seconds: 3)); // Simulate saving the list to disk
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', null);
    username = null;
    password = null;
    notifyListeners();
  }
}
