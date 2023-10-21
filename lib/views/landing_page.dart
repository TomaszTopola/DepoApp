import 'package:depo_app/common_widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../common_widgets/depo_chart.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,

        child: Scaffold(
          endDrawer: const DepoDrawer(),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Korab'),
                Tab(text: 'Pasat'),
              ],
            ),
            title: const Text('DepoApp'),

          ),
          body: TabBarView(
            children: [
              //KORAB
              ListView(
                children: const [
                  DepoChart(
                    chartHeight: 300,
                    sdm: "KORAB",
                  )
                ],
              ),

              //PASAT
              ListView(
                children: const [
                  const DepoChart(
                    chartHeight: 300,
                    sdm: "PASAT",
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}
