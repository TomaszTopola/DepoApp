import 'package:depo_app/common_widgets/drawer.dart';
import 'package:depo_app/common_widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late double deviceWidth;
  late double deviceHeight;
  late Widget loginPage;

  @override
  Widget build(BuildContext context){


    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    if(deviceHeight > deviceWidth){
      if(deviceHeight >= 800){
        loginPage = Padding(
          padding: EdgeInsets.all(deviceHeight / 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  flex: 1,
                  child: loginImage
              ),
              Flexible(
                  flex: 2,
                  child: loginForm
              ),
            ],
          ),
        );
      }if(deviceHeight > 600 && deviceHeight < 800){
        loginPage = Padding(
          padding: EdgeInsets.all(deviceHeight / 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  flex: 3,
                  child: loginImage
              ),
              Divider(
                height: deviceHeight / 10,
              ),
              Flexible(
                  flex: 2,
                  child: loginForm
              ),
            ],
          ),
        );
      }if(deviceHeight < 600){
        loginPage = Padding(
          padding: EdgeInsets.all(deviceHeight / 60),
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: loginImage
              ),
              Divider(
                height: deviceHeight / 40,
              ),
              Flexible(
                flex: 2,
                child: ListView(children: [
                  loginForm
                ]
                ),
              ),
            ],
          ),
        );
      }
    }else if(deviceHeight < 380) {
      loginPage = Padding(
        padding: EdgeInsets.all(deviceHeight / 38),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginImage,
                  ],
                )
            ),
            Flexible(
                flex: 4,
                child: ListView(
                  children: [
                    loginForm,
                  ],
                )
            ),
          ],
        ),
      );
    }else{
      loginPage = Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginImage,
                  ],
                )
            ),
            Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginForm,
                  ],
                )
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('DepoApp'),
        ),
        endDrawer: const DepoDrawer(),
        body: loginPage
    );
  }
}

Widget loginImage = Expanded(
  child: FractionallySizedBox(
    widthFactor: 0.8,
    child: SvgPicture.asset(
      'assets/login.svg',
    ),
  ),
);

Widget loginForm = const Column(
  children: [
    Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: LoginForm(),
    ),
  ],
);
