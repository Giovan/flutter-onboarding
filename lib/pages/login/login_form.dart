part of 'login_page.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2, // 20%
                  child: Container(color: Colors.transparent),
                ),
                Expanded(
                  flex: 6, // 60%
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        controller: _emailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      new Center(
                        child: new RichText(
                          text: new TextSpan(
                            children: [
                              new TextSpan(
                                text: 'Forgot your password?',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/recover-password');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity, // match_parent
                        child: RaisedButton(
                          onPressed:
                          state is! LoginLoading ? _onLoginButtonPressed : null,
                          child: Text('Login'),
                        ),
                      ),
                      new Center(
                        child: new RichText(
                          text: new TextSpan(
                            children: [
                              new TextSpan(
                                text: "Don't have account?  ",
                                style: new TextStyle(color: Colors.black),
                              ),
                              new TextSpan(
                                text: 'Sign Up',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/signup');
                                    // launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: state is LoginLoading
                            ? CircularProgressIndicator()
                            : null,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(color: Colors.transparent),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
