import 'package:depo_app/common/extensions.dart';
import 'package:depo_app/services/server/depo_service.dart';
import 'package:depo_app/services/server/user_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DepoChart extends StatefulWidget {
  const DepoChart({Key? key, required this.chartHeight, required this.sdm}) : super(key: key);

  final double chartHeight;
  final String sdm;

  @override
  State<DepoChart> createState() => _DepoChartState();
}

class _DepoChartState extends State<DepoChart> {

  late Color primary;
  late Color error;
  late Color secondary;

  late Widget spinner = SpinKitWave(
      color: primary,
      size: 50
  );
  
  late Widget displayWidget = spinner;

  late List<Widget> keeperList = [
    SpinKitWave(
      color: primary,
      size: 40,
    )
  ];

  void setupChart() async{
    generateList();
    final double activeDepos = await DepoService.countDepos(widget.sdm, 'ACTIVE');
    final contactedDepos = await DepoService.countDepos(widget.sdm, 'CONTACTED');
    final outdatedDepos = await DepoService.countDepos(widget.sdm, 'OUTDATED');
    final disposedDepos = await DepoService.countDepos(widget.sdm, 'DISPOSED');

    const double deposLimit = 60.0;
    double displayActiveDepos = activeDepos + contactedDepos + outdatedDepos + disposedDepos;

    setState(() {

      if(activeDepos == -1.0){
        displayWidget = IconButton(
          onPressed: (){
            setState(() {
              displayWidget = spinner;
              setupChart();
            });
          },
          icon: const Icon(Icons.refresh),
        );
        return;
      }

      if(displayActiveDepos > deposLimit){
        displayActiveDepos = deposLimit;
      }

      displayWidget = Row(
        children: [
          Flexible(
            flex: 2,
            child: PieChart(
                PieChartData(
                    centerSpaceRadius: 0,
                    startDegreeOffset: 270,
                    // sectionsSpace: widget.chartHeight/50,
                    sections: [
                      PieChartSectionData(
                          color: error,
                          value: displayActiveDepos,
                          showTitle: false,
                          radius: widget.chartHeight *0.25
                      ),
                      PieChartSectionData(
                        color: primary,
                        value: deposLimit - displayActiveDepos,
                        showTitle: false,
                        radius: widget.chartHeight *0.25,
                      ),
                    ]
                )
            ),
          ),
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: error,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('Zajęte miejsca: ${(displayActiveDepos/deposLimit*100).toPrecision(2)}%'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: primary,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('Wolne miejsca: ${((deposLimit-displayActiveDepos)/deposLimit*100).toPrecision(2)}%'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: secondary,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('Aktywne: $activeDepos'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: secondary,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('Po kontakcie: $contactedDepos'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: secondary,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('Przeterminowane: $outdatedDepos'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: secondary,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('Zgoda na utylizację: $disposedDepos'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                const Text('Opiekunowie depozytu:'),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    children: keeperList,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  void generateList() async{
    dynamic keepers = await UserService.getKeepers();
    if(keepers == -1){
      keeperList = [
        const SizedBox(height: 30,),
        const Text('Użytkownik niezalogowany'),
        const SizedBox(height: 10,),
        ElevatedButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('zaloguj'),
        )
      ];
      return;
    }
    List<Widget> generatedKeeperList = [];
    for (dynamic keeper in keepers){
      if(keeper['permits'].contains('ADMIN')){
        generatedKeeperList.add(const SizedBox(height: 10,));
        generatedKeeperList.add(
            Material(
              elevation: 5.0,
              shadowColor: secondary,
              borderRadius: BorderRadius.circular(15.0),
              child: ListTile(
                leading: Icon(Icons.admin_panel_settings, color: primary),
                title: Text('${keeper['first_name']} ${keeper['last_name']}'),
              ),
            )
        );
        continue;
      }
      if(keeper['permits'].contains(widget.sdm)){
        generatedKeeperList.add(const SizedBox(height: 10,));
        generatedKeeperList.add(
          Material(
            elevation: 5.0,
            shadowColor: secondary,
            borderRadius: BorderRadius.circular(15.0),
            child: ListTile(
              leading: Icon(Icons.account_circle, color: primary),
              title: Text('${keeper['first_name']} ${keeper['last_name']}'),
            ),
          )
        );
      }
    }
    setState(() {
      keeperList = generatedKeeperList;
    });
  }

  @override
  void initState(){
    super.initState();
    setupChart();
  }

  @override
  Widget build(BuildContext context) {
    primary = Theme.of(context).colorScheme.primary;
    error = Theme.of(context).colorScheme.error;
    secondary = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      height: widget.chartHeight,
      child: Card(
        child: displayWidget,
      ),
    );
  }
}
