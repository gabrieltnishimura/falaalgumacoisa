import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final FirebaseUser user;

  LoggedIn({@required this.user}) : super();

  @override
  String toString() => 'LoggedIn { credential: ${user.toString()} }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
