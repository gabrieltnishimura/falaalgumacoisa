import 'package:falaalgumacoisa/login/authentication_bloc.dart';
import 'package:falaalgumacoisa/login/login_bloc.dart';
import 'package:falaalgumacoisa/login/login_event.dart';
import 'package:falaalgumacoisa/login/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _signInButton(_loginBloc),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  Widget _signInButton(LoginBloc loginBloc) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        loginBloc.add(GoogleLoginSelected());
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
