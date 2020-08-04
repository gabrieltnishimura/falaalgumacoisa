import 'dart:async';

import 'package:falaalgumacoisa/login/authentication_event.dart';
import 'package:falaalgumacoisa/login/authentication_state.dart';
import 'package:falaalgumacoisa/login/user_repository.dart';
import 'package:falaalgumacoisa/models/user_data_model.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    final UserDataModel user = await userRepository.getModel();
    final bool hasToken = await userRepository.hasToken();
    if (event is AppStarted) {
      print('Checking if hasToken initialized $hasToken');

      if (!hasToken) {
        yield AuthenticationUnauthenticated();
      } else {
        if (user != null) {
          yield AuthenticationAuthenticatedRegistered();
        } else {
          yield AuthenticationAuthenticatedNotRegistered();
        }
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      if (user != null) {
        yield AuthenticationAuthenticatedRegistered();
      } else {
        yield AuthenticationAuthenticatedNotRegistered();
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}
