import 'package:dflow/main.dart';
import 'package:dflow/models/User.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) =>
    AppState(userReducer(state.user, action));

final Reducer<User> userReducer = combineReducers<User>([
  TypedReducer<User, LoginAction>(_login),
  TypedReducer<User, LogoutAction>(_logout),
 // TypedReducer<User, InitAction>(_init),
  TypedReducer<User, InitComplete>(_init),
]);

User _login(User user, LoginAction action)  => action.user;

//User _init(User user, InitAction action)  => action.user;
User _init(User user, InitComplete action)  => action.user;

User _logout(User user, LogoutAction action) => null;
