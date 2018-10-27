import 'package:dflow/screens/home/home_screen.dart';
import 'package:dflow/screens/login/login_screen.dart';
import 'package:flutter/widgets.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/' :          (BuildContext context) => new LoginScreen(),
};