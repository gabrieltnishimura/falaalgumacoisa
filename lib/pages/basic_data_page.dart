import 'package:falaalgumacoisa/forms/basic_data_form.dart';
import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:falaalgumacoisa/pages/record_page.dart';
import 'package:falaalgumacoisa/services/user_service.dart';
import 'package:flutter/material.dart';

import '../service_locator.dart';

class BasicDataPage extends StatelessWidget {
  final UserService _userService = locator<UserService>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDataModel>(
        future: _userService.retrieve(),
        builder: (BuildContext context, AsyncSnapshot<UserDataModel> snapshot) {
          if (snapshot.hasData) {
            return RecordPage();
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Basic Data Page'),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BasicDataForm(),
                    ],
                  ),
                ));
          }
        });
  }
}
