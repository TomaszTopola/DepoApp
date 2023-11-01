import 'package:depo_app/common_widgets/depo/depo_list.dart';
import 'package:depo_app/common_widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../common_widgets/depo/depo_chart.dart';

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
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add_card),
            onPressed: (){
              Navigator.pushNamed(context, '/depo/edit');
            },
          ),
          body: const TabBarView(
            children: [
              //KORAB
              Column(
                children: [
                  DepoChart(
                    chartHeight: 300,
                    sdm: "KORAB",
                  ),
                  Expanded(child: DepoList(sdm: 'KORAB'))
                ],
              ),

              //PASAT
              Column(
                children: [
                  DepoChart(
                    chartHeight: 300,
                    sdm: "PASAT",
                  ),
                  Expanded(child: DepoList(sdm: 'PASAT')),
                ],
              ),
            ],
          ),
        )
    );
  }
}
