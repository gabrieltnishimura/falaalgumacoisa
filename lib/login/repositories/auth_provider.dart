import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthProvider {
  Future<AuthCredential> authenticate();
}

enum AuthProvidersEnum {
  GOOGLE,
  FACEBOOK,
}
