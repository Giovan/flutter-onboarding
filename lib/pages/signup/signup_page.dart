import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_onboarding/components/authentication/authentication.dart';
import 'package:flutter_onboarding/components/signup/signup_bloc.dart';

part 'signup_form.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return SignUpBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          );
        },
        child: SignUpForm(),
      ),
    );
  }
}
