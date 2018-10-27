import 'package:dflow/models/User.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  String username;
  String password;
  bool isLogin;
  final Store<AppState> _store;

  LoginViewModel(this.username, this.password, this.isLogin, this._store);

  factory LoginViewModel.create(Store<AppState> store) {
    return LoginViewModel(store.state.user?.username,
        store.state.user?.password, store.state.user != null, store);
  }

  login() {
    _store.dispatch(LoginAction(User(username, password)));
  }
}
