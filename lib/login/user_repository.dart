import 'package:falaalgumacoisa/login/repositories/auth_provider.dart';
import 'package:falaalgumacoisa/login/repositories/google_auth_repository.dart';
import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const TOKEN_KEY = 'FIREBASE_TOKEN_ID_TESTE';
  UserDataModel _currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> authenticate({
    @required AuthProvidersEnum provider,
  }) async {
    AuthCredential credential;
    if (provider == AuthProvidersEnum.GOOGLE) {
      credential = await GoogleAuthRepository().getCredentials();
    }
    if (credential == null) {
      throw AuthException('internal-repository',
          'Invalid authentication repository (${provider.toString()})');
    }
    return (await _auth.signInWithCredential(credential)).user;
  }

  Future<void> signOut() async {
    return this._auth.signOut();
  }

  Future<bool> hasToken() async {
    return await this._auth.currentUser() != null;
  }

  Future<void> saveModel({UserDataModel user}) async {
    // move auth data to database?
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('age', user.age);
    await prefs.setString('sex', user.sex);
    await prefs.setString('origin', user.motherLanguage);
    await prefs.setString('motherLanguage', user.motherLanguage);
    this._currentUser = user;
  }

  Future<UserDataModel> getModel() async {
    if (this._currentUser != null) {
      return _currentUser;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('age') ||
        !prefs.containsKey('sex') ||
        !prefs.containsKey('origin') ||
        !prefs.containsKey('motherLanguage')) {
      return null;
    }

    return UserDataModel(
        age: prefs.getString('age'),
        sex: prefs.getString('sex'),
        origin: prefs.getString('origin'),
        motherLanguage: prefs.getString('motherLanguage'));
  }
}
