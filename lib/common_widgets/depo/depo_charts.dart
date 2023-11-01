import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

@Deprecated('Use DepoChart instead')
class DepoCharts extends StatefulWidget {
  const DepoCharts({Key? key, required this.chartHeight}) : super(key: key);
  final double chartHeight;

  @override
  State<DepoCharts> createState() => _DepoChartsState();
}

class _DepoChartsState extends State<DepoCharts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2,
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          //header
          SizedBox(height: widget.chartHeight/8,),
          Text(
            'Dostępne miejsca w depozytach:',
            style: TextStyle(
              fontSize: widget.chartHeight/8,
              color: Theme.of(context).colorScheme.onSecondary,
          )),
          SizedBox(height: widget.chartHeight/8,),

          //charts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.chartHeight,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                          PieChartData(
                              centerSpaceRadius: 0,
                              startDegreeOffset: 270,
                              sectionsSpace: widget.chartHeight/50,
                              sections: [
                                PieChartSectionData(
                                    color: Theme.of(context).colorScheme.error,
                                    value: 80,
                                    showTitle: false,
                                    radius: widget.chartHeight/2.5 - widget.chartHeight/20
                                ),
                                PieChartSectionData(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  value: 20,
                                  showTitle: false,
                                  radius: widget.chartHeight/2.5,
                                ),
                              ]
                          )
                      ),
                    ),
                    Text('SDM Korab',
                      style: TextStyle(
                        fontSize: widget.chartHeight/10,
                        color: Theme.of(context).colorScheme.onSecondary
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.chartHeight,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                          PieChartData(
                              centerSpaceRadius: 0,
                              startDegreeOffset: 270,
                              sectionsSpace: widget.chartHeight/50,
                              sections: [
                                PieChartSectionData(
                                  color: Theme.of(context).colorScheme.error,
                                  value: 65,
                                  showTitle: false,
                                  radius: widget.chartHeight/2.5 - widget.chartHeight/20,
                                ),
                                PieChartSectionData(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  value: 35,
                                  showTitle: false,
                                  radius: widget.chartHeight/2.5,
                                ),
                              ]
                          )
                      ),
                    ),
                    Text('SDM Pasat',
                      style: TextStyle(
                        fontSize: widget.chartHeight/10,
                        color: Theme.of(context).colorScheme.onSecondary
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Divider(
            thickness: 2,
            height: widget.chartHeight/4,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),

          //Chart description
          SizedBox(
            width: widget.chartHeight*2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: widget.chartHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('wolne',
                        style: TextStyle(
                          fontSize: widget.chartHeight/10,
                          color: Theme.of(context).colorScheme.onSecondary
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.chartHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      SizedBox(width: widget.chartHeight/10,),
                      Text('zajęte',
                        style: TextStyle(
                          fontSize: widget.chartHeight/10,
                          color: Theme.of(context).colorScheme.onSecondary
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: widget.chartHeight/8),
        ],
      ),
    );
  }
}
