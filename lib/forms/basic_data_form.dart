import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:falaalgumacoisa/pages/record_page.dart';
import 'package:falaalgumacoisa/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../service_locator.dart';
import 'custom_dropdown_widget.dart';

class BasicDataForm extends StatefulWidget {
  @override
  BasicDataFormState createState() {
    return BasicDataFormState();
  }
}

class BasicDataFormState extends State<BasicDataForm> {
  final UserService _userService = locator<UserService>();
  final _formKey = GlobalKey<FormState>();
  final _user = UserDataModel();
  final Function callback;

  BasicDataFormState({this.callback});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            width: 350,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: 'Idade',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Escolha uma idade';
                      }
                      return null;
                    },
                    onChanged: (val) => setState(() => _user.age = val),
                  ),
                  CustomDropdownWidget(
                    value: _user.sex,
                    validation: 'Selecione sexo',
                    placeholder: 'Selecione o sexo',
                    callback: (newValue) {
                      setState(() {
                        _user.sex = newValue;
                      });
                    },
                    dropdownValues: ['Masculino', 'Feminino'],
                  ),
                  CustomDropdownWidget(
                    value: _user.origin,
                    placeholder: 'Selecione o estado de nascimento',
                    validation: 'Selecione um estado válido',
                    callback: (newValue) {
                      setState(() {
                        _user.origin = newValue;
                      });
                    },
                    dropdownValues: ['SP', 'RJ'],
                  ),
                  CustomDropdownWidget(
                      value: _user.motherLanguage,
                      placeholder: 'Selecione a língua materna',
                      validation: 'Selecione uma língua válida',
                      callback: (newValue) {
                        setState(() {
                          _user.motherLanguage = newValue;
                        });
                      },
                      dropdownValues: ['Português', 'Inglês']),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print('[BASIC DATA] Saving user\n' + _user.toString());
                        _userService.save(user: _user).then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecordPage()),
                          );
                        });
                      }
                    },
                    child: Text(
                      'Enviar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])));
  }
}
