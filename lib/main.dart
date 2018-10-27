import 'package:dflow/models/User.dart';
import 'package:dflow/models/middleware.dart';
import 'package:dflow/models/reducer.dart';
import 'package:dflow/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    /* Function defined in the reducers file */
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(),
  );
  runApp(new DFlowApp(store));
}

class DFlowApp extends StatefulWidget {
  DFlowApp(this.store);

  final Store<AppState> store;

  @override
  _DFlowAppState createState() => _DFlowAppState();
}

class _DFlowAppState extends State<DFlowApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: MaterialApp(
        title: 'D-Flow App',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: routes,
      ),
    );
  }
}

/*class DFlowApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer, */ /* Function defined in the reducers file */ /*
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      StoreProvider(
        store: this.store,
        child: MaterialApp(
          title: 'D-Flow App',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: routes,
        ),
      );
}*/
