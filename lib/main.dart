import 'package:dflow/routes.dart';
import 'package:dflow/screens/home/map_model.dart';
import 'package:dflow/screens/login/login_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(DFlowApp(
    loginScopedModel: LoginScopedModel(),
    mapScopedModel: MapScopedModel(),
  ));
}

class DFlowApp extends StatelessWidget {
  final LoginScopedModel loginScopedModel;
  final MapScopedModel mapScopedModel;

  const DFlowApp({
    Key key,
    @required this.loginScopedModel,
    @required this.mapScopedModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginScopedModel>(
      model: loginScopedModel,
      child: ScopedModel<MapScopedModel>(
        model: mapScopedModel,
        child: MaterialApp(
          title: 'D-Flow App',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: routes,
        ),
      ),
    );
  }
}


