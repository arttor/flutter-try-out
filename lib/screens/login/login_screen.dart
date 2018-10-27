import 'dart:ui';

import 'package:dflow/models/User.dart';
import 'package:dflow/screens/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  BuildContext _ctx;
  String usr;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this.formKey,
            child: StoreConnector<AppState, LoginViewModel>(
              converter: (Store<AppState> store) =>
                  LoginViewModel.create(store),
              onDidChange: (view) {
                if (view.username != null)
                  Navigator.of(_ctx).pushReplacementNamed("/home");
              },
              builder: (BuildContext context, LoginViewModel viewModel) =>
                  ListView(
                    children: <Widget>[
                      new TextFormField(
                          onSaved: (val) => viewModel.username = val,
                          initialValue: viewModel.username,
                          validator: (val) {
                            return val.length < 1 ? "Fill user" : null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          // Use email input type for emails.
                          decoration: new InputDecoration(
                              hintText: 'you@example.com',
                              labelText: 'E-mail Address')),
                      new TextFormField(
                          onSaved: (val) => viewModel.password = val,
                          obscureText: true, // Use secure text for passwords.
                          decoration: new InputDecoration(
                              hintText: 'Password',
                              labelText: 'Enter your password')),
                      new Container(
                        width: screenSize.width,
                        child: new RaisedButton(
                          child: new Text(
                            'Login',
                            style: new TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              viewModel.login();
                            }
                            if (viewModel.username != null) {
                              Navigator.of(_ctx).pushReplacementNamed("/home");
                            }
                          },
                          color: Colors.blue,
                        ),
                        margin: new EdgeInsets.only(top: 20.0),
                      )
                    ],
                  ),
            ),
          )),
    );
  }
}
