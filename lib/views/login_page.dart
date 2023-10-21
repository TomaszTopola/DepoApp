import 'package:depo_app/common_widgets/drawer.dart';
import 'package:depo_app/common_widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mój Depozyt'),
      ),
      endDrawer: const DepoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.4,
              child: SvgPicture.asset(
                'assets/login.svg',
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: LoginForm(),
            )
          ],
        )
      ),
    );
  }
}
