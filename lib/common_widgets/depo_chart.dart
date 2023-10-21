import 'package:depo_app/services/depo_service.dart';
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

  late Widget spinner = Center(
    child: SpinKitWave(
        color: primary,
        size: 50
    ),
  );
  
  late Widget displayWidget = spinner;

  void setupChart() async{
    double activeDepos = await DepoService.countDepos(widget.sdm);
    const double deposLimit = 60.0;
    double displayActiveDepos = activeDepos;

    print(activeDepos);

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

      if(activeDepos > deposLimit){
        displayActiveDepos = deposLimit;
      }

      displayWidget = Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
                PieChartData(
                    centerSpaceRadius: 0,
                    startDegreeOffset: 270,
                    sectionsSpace: widget.chartHeight/50,
                    sections: [
                      PieChartSectionData(
                          color: error,
                          value: displayActiveDepos,
                          showTitle: false,
                          radius: widget.chartHeight/2.5 - widget.chartHeight/20
                      ),
                      PieChartSectionData(
                        color: primary,
                        value: deposLimit - displayActiveDepos,
                        showTitle: false,
                        radius: widget.chartHeight/2.5,
                      ),
                    ]
                )
            ),
          ),
        ],
      );

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
    return displayWidget;
  }
}
