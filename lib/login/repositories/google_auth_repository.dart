import 'package:falaalgumacoisa/login/repositories/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthRepository extends AuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<AuthCredential> authenticate() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    return GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }
}
