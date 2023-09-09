import 'package:depo_app/common_widgets/depo_charts.dart';
import 'package:depo_app/common_widgets/drawer.dart';
import 'package:depo_app/common_widgets/meeting_reguest.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 35.0),
                DepoCharts(
                  chartHeight: (MediaQuery.of(context).size.width - 30)/3
                ),
                const SizedBox(height: 35,),
                const MeetingRequest(),
                const SizedBox(
                  height: 600,
                )
              ],
            ),
          )
        )
    );
  }
}
