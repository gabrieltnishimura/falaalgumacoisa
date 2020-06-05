import 'package:falaalgumacoisa/login/repositories/auth_provider.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent {
  final AuthProvidersEnum provider;

  LoginEvent({@required this.provider});

  @override
  String toString() => 'base login event';
}

class GoogleLoginSelected extends LoginEvent {
  final AuthProvidersEnum provider = AuthProvidersEnum.GOOGLE;

  @override
  String toString() =>
      'GoogleLoginSelected { provider: ${provider.toString()} }';
}
