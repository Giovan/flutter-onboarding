import 'dart:async';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_onboarding/components/authentication/authentication.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc authenticationBloc;

  SignUpBloc({@required this.authenticationBloc}) : assert(authenticationBloc != null);

  @override
  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();

      try {
        final token = '-';
        authenticationBloc.add(LoggedIn(token: token));
        yield SignUpInitial();
      } catch (error) {
        yield SignUpFailure(error: error.toString());
      }
    }
  }
}
