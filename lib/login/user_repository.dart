import 'package:falaalgumacoisa/login/repositories/auth_provider.dart';
import 'package:falaalgumacoisa/login/repositories/auth_provider_factory.dart';
import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  AuthCredential inMemory;
  UserDataModel _currentUser;

  Future<AuthCredential> authenticate({
    @required AuthProvidersEnum provider,
  }) async {
    AuthProvider repository = AuthProviderFactory.getAuthProvider(provider);
    if (repository == null) {
      throw AuthException('internal-repository',
          'Invalid authentication repository (${provider.toString()})');
    }
    return await repository.authenticate();
  }

  Future<void> deleteToken() async {
    inMemory = null;
    return;
  }

  Future<void> persistToken(AuthCredential credential) async {
    inMemory = credential;
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    return inMemory != null;
  }

  Future<void> saveModel({UserDataModel user}) async {
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
    if (prefs.getString('age').isEmpty ||
        prefs.getString('sex').isEmpty ||
        prefs.getString('origin').isEmpty ||
        prefs.getString('motherLanguage').isEmpty) {
      return null;
    }

    return UserDataModel(
        age: prefs.getString('age'),
        sex: prefs.getString('sex'),
        origin: prefs.getString('origin'),
        motherLanguage: prefs.getString('motherLanguage'));
  }
}
