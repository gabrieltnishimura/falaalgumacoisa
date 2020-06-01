class UserDataModel {
  String age;
  String sex;
  String origin;
  String motherLanguage;

  UserDataModel({this.age, this.sex, this.origin, this.motherLanguage});

  @override
  String toString() {
    return 'Age: $age, Sex: $sex, Origin: $origin, Mother Language: $motherLanguage';
  }
}
