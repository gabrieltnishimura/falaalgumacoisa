import 'dart:async';

import 'package:falaalgumacoisa/login/authentication_bloc.dart';
import 'package:falaalgumacoisa/login/authentication_event.dart';
import 'package:falaalgumacoisa/login/login_event.dart';
import 'package:falaalgumacoisa/login/login_state.dart';
import 'package:falaalgumacoisa/login/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginLoading();
    try {
      final AuthCredential credential = await userRepository.authenticate(
        provider: event.provider,
      );

      authenticationBloc.add(LoggedIn(credential: credential));
      yield LoginInitial();
    } catch (error) {
      yield LoginFailure(error: error.toString());
    }
  }
}
