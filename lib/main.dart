import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter_onboarding/repositories/user_repository.dart';

import 'package:flutter_onboarding/components/authentication/authentication.dart';
import 'package:flutter_onboarding/common/common.dart';

import 'package:flutter_onboarding/routes.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());
        },
        child: App(userRepository: userRepository),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  final String name = 'App';
  final FirebaseOptions options = const FirebaseOptions(
    googleAppID: '',
    gcmSenderID: '',
    apiKey: '',
  );

  Future<void> _configure() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: name,
      options: options,
    );
    assert(app != null);
    print('Configured $app');
  }

  Future<void> _allApps() async {
    final List<FirebaseApp> apps = await FirebaseApp.allApps();
    print('Currently configured apps: $apps');
  }

  Future<void> _options() async {
    final FirebaseApp app = await FirebaseApp.appNamed(name);
    final FirebaseOptions options = await app?.options;
    print('Current options for app $name: $options');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return pages['home'];
            }
            if (state is AuthenticationUnauthenticated) {
              return pages['login'];
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            return pages['splash'];
          },
        ),
        routes: routes
    );
  }
}
