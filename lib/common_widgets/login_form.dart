import 'package:depo_app/services/server/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  Widget buttonChild = const Text('zaloguj się');

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.setClientFeatures', <String, dynamic>{
      'setAuthenticationConfiguration': true,
      'setAutofillHints': <String> [
        AutofillHints.username,
        AutofillHints.password,
      ],
    });
  }

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
          AutofillGroup(
            child: Column(
              children: [
                TextFormField(
                  controller: _loginController,
                  autofillHints: const [AutofillHints.username],
                  decoration: const InputDecoration(
                      hintText: 'numer albumu',
                      labelText: 'numer albumu'
                  ),
                ),
                TextFormField(
                  controller: _passController,
                  obscureText: _hidePassword,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.password],
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
              ],
            )
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              TextInput.finishAutofillContext();
              setState(() {
                buttonChild = SpinKitWave(
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20
                );
              });
              bool isLoggedIn = await UserService.login(_loginController.text, _passController.text);
              if(isLoggedIn) {
                await Navigator.pushReplacementNamed(context, '/landing');
                return;
              }
              //TODO: add dialog for login errors;
              setState(() {
                buttonChild = const Text('zaloguj się');
              });
            },
            child: buttonChild
          ),
          const SizedBox(height: 20,),
          const Text(
            'W przypadku problemów z logowaniem skontaktuj się z Przewodniczącym Komisji ds. Mieszkaniowych.\n'
                'Aplikacja przeznaczona jest wyłącznie dla opiekunów depozytów.',
          ),
          const SizedBox(height: 20,),
          TextButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/landing');
            },
            child: Text(
              'kontynuuj bez logowania',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
            )
          ),
        ],
      ),
    );
  }
}
