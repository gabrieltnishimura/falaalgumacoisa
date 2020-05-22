class ConfigModel {
  final String dropboxAccessToken;
  ConfigModel({this.dropboxAccessToken = ""});
  factory ConfigModel.fromJson(Map<String, dynamic> jsonMap) {
    return new ConfigModel(dropboxAccessToken: jsonMap["DROPBOX_ACCESS_TOKEN"]);
  }
}
