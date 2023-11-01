import 'package:depo_app/common_widgets/depo/depo_form.dart';
import 'package:flutter/material.dart';

import '../common_widgets/drawer.dart';


class EditDepo extends StatelessWidget {
  const EditDepo({Key? key, this.depo}) : super(key: key);

  final dynamic depo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mój Depozyt'),
        ),
        endDrawer: const DepoDrawer(),
        body: DepoForm()
      )
    );
  }
}
