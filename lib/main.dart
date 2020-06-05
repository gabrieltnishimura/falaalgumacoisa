import 'package:falaalgumacoisa/login/authentication_bloc.dart';
import 'package:falaalgumacoisa/login/authentication_event.dart';
import 'package:falaalgumacoisa/login/authentication_state.dart';
import 'package:falaalgumacoisa/login/loading_indicator.dart';
import 'package:falaalgumacoisa/login/login_page.dart';
import 'package:falaalgumacoisa/login/splash_page.dart';
import 'package:falaalgumacoisa/login/user_repository.dart';
import 'package:falaalgumacoisa/pages/basic_data_page.dart';
import 'package:falaalgumacoisa/pages/record_page.dart';
import 'package:falaalgumacoisa/service_locator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              if (userRepository.getModel() == null) {
                return BasicDataPage(userRepository: userRepository);
              } else {
                return RecordPage();
              }
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            return Container();
          },
        ),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      ),
    );
  }
}
