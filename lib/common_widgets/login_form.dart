import 'package:depo_app/services/user_service.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passController = TextEditingController();

  bool _hidePassword = true;
  Icon _passStateIcon = const Icon(Icons.visibility);

  @override
  void dispose() {
    _loginController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
          controller: _loginController,

          decoration: const InputDecoration(
              hintText: 'numer albumu',
              labelText: 'numer albumu'
            ),
          ),
          TextFormField(
            controller: _passController,
            obscureText: _hidePassword,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
            hintText: 'hasło',
            labelText: 'hasło',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                  _passStateIcon = _hidePassword? const Icon(Icons.visibility) : const Icon(Icons.visibility_off);
                });
              },
              icon: _passStateIcon
              )
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              bool isLoggedIn = await UserService.login(_loginController.text, _passController.text);
              if(!isLoggedIn) {
              //TODO: add dialog for login errors;
              }
              //TODO: add navigator redirection
            },
            child: const Text('zaloguj się')
          ),
          const SizedBox(height: 20,),
          const Text(
            'W przypadku problemów z logowaniem skontaktuj się z Przewodniczącym Komisji ds. Mieszkaniowych\n'
                'Aplikacja przeznaczona jest wyłącznie dla opiekunów depozytów.',
          )
        ],
      ),
    );
  }
}
