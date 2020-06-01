import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  UserDataModel _currentUser;

  Future<void> save({UserDataModel user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('age', user.age);
    await prefs.setString('sex', user.sex);
    await prefs.setString('origin', user.motherLanguage);
    await prefs.setString('motherLanguage', user.motherLanguage);
    this._currentUser = user;
  }

  Future<UserDataModel> retrieve() async {
    if (this._currentUser != null) {
      return _currentUser;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserDataModel(
        age: prefs.getString('age'),
        sex: prefs.getString('sex'),
        origin: prefs.getString('origin'),
        motherLanguage: prefs.getString('motherLanguage'));
  }
}
