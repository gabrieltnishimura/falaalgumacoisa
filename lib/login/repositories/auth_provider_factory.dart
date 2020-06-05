import 'package:falaalgumacoisa/login/repositories/auth_provider.dart';
import 'package:falaalgumacoisa/login/repositories/google_auth_repository.dart';

class AuthProviderFactory {
  static AuthProvider getAuthProvider(AuthProvidersEnum event) {
    if (event == AuthProvidersEnum.GOOGLE) {
      return GoogleAuthRepository();
    }
    return null;
  }
}
