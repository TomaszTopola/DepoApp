import 'package:depo_app/common_widgets/depo_list.dart';
import 'package:flutter/material.dart';

import '../common_widgets/drawer.dart';

class CheckStatus extends StatelessWidget {
  const CheckStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mój Depozyt'),
        ),
        endDrawer: const DepoDrawer(),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: const DepoList()
        ),
      )
    );
  }
}
