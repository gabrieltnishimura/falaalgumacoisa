import 'package:falaalgumacoisa/basic_data/basic_data_form.dart';
import 'package:falaalgumacoisa/login/user_repository.dart';
import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:falaalgumacoisa/pages/record_page.dart';
import 'package:flutter/material.dart';

class BasicDataPage extends StatefulWidget {
  final UserRepository userRepository;

  BasicDataPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<BasicDataPage> createState() => _BasicDataPageState();
}

class _BasicDataPageState extends State<BasicDataPage> {
  UserRepository get _userRepository => widget.userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic data Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BasicDataForm(
              saveForm: this._saveForm,
            ),
          ],
        ),
      ),
    );
  }

  void _saveForm(UserDataModel user) {
    _userRepository.saveModel(user: user).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecordPage()),
      );
    });
  }
}
