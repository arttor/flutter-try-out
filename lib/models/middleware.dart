import 'dart:async';

import 'package:dflow/models/User.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createStoreMiddleware() => [
  TypedMiddleware<AppState, LoginAction>(_login),
  TypedMiddleware<AppState, LogoutAction>(_logout),
  TypedMiddleware<AppState, InitAction>(_init),
];

Future _login(Store<AppState> store, LoginAction action, NextDispatcher next) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', action.user.username);
  next(action);
}

Future _logout(Store<AppState> store, LogoutAction action, NextDispatcher next) async {
  await Future.sync(() => Duration(seconds: 3)); // Simulate saving the list to disk
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', null);
  next(action);
}

Future _init(Store<AppState> store, InitAction action, NextDispatcher next) async {
  final prefs = await SharedPreferences.getInstance();
  var u = prefs.getString('user');

  next(InitComplete(User(u, null)));
}