part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String surname;
  final String email;
  final String password;

  const SignUpButtonPressed({
    @required this.name,
    @required this.surname,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [name, surname, email, password];

  @override
  String toString() =>
      'SignUpButtonPressed { name: $name, surname: $surname'
          ', email: $email, password: $password }';
}
