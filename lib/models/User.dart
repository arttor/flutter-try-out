class User {
  String _username;
  String _password;

  String get username => _username;
  String get password => _password;

  User(this._username, this._password);
}

class AppState {
  final User user;

  AppState(this.user);

  factory AppState.initial() => AppState(null);
}


class LoginAction {
  final User user;

  LoginAction(this.user);
}

class LogoutAction {
  final User user;

  LogoutAction(this.user);
}
class InitAction {
}
class InitComplete {
  final User user;

  InitComplete(this.user);
}