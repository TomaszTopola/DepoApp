import 'dart:math';

import 'package:depo_app/services/user_service.dart';
import 'package:flutter/material.dart';

class DepoDrawer extends StatefulWidget {
  const DepoDrawer({Key? key}) : super(key: key);

  @override
  State<DepoDrawer> createState() => _DepoDrawerState();
}

class _DepoDrawerState extends State<DepoDrawer> {

  bool isLoggedIn = false;
  String loggedInTitle = 'zaloguj się';

  void checkLoggedIn() async{
    isLoggedIn = await UserService.isTokenValid();
    setState(() {
      loggedInTitle = isLoggedIn? 'wyloguj':'zaloguj się';
    });
    print(loggedInTitle);
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {

    final route = ModalRoute.of(context)?.settings.name;

    int selectedIndex = 0;

    switch(route){
      case '/landing':
        selectedIndex = 0;
        break;
      case '/depo/status':
        selectedIndex = 1;
        break;
      case '/contact':
        selectedIndex = 2;
        break;
      case '/login':
        selectedIndex = 3;
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary
            ),
            child: Text(
              'Mój Deopzyt',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          ListTile(
            selected: selectedIndex == 0,
            selectedTileColor: Theme.of(context).colorScheme.secondary,
            selectedColor: Theme.of(context).colorScheme.onSecondary,
            title: const Text('Strona Główna'),
            onTap: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/landing');
              });
            },
          ),
          const SizedBox(height: 10,),
          ListTile(
            selected: selectedIndex == 1,
            selectedTileColor: Theme.of(context).colorScheme.secondary,
            selectedColor: Theme.of(context).colorScheme.onSecondary,
            title: const Text('sprawdź status depozytu'),
            onTap: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/depo/status');
              });
            },
          ),
          const SizedBox(height: 10,),
          ListTile(
            selected: selectedIndex == 2,
            selectedTileColor: Theme.of(context).colorScheme.secondary,
            selectedColor: Theme.of(context).colorScheme.onSecondary,
            title: const Text('kontakt'),
            onTap: () {},
          ),
          const SizedBox(height: 10,),
          ListTile(
            selected: selectedIndex == 3,
            selectedTileColor: Theme.of(context).colorScheme.secondary,
            selectedColor: Theme.of(context).colorScheme.onSecondary,
            title: Text(loggedInTitle,
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
            onTap: () {
              if(isLoggedIn){
                setState(() {
                  UserService.logout();
                });
              }
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
