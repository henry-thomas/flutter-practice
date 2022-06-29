import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/energy_chart_manager.dart';
import 'package:provider_test/screens/chartScreen/chartComponents/chart_date_picker.dart';

class EnergyChart extends StatefulWidget {
  final List<BarChartGroupData> groupsList;

  const EnergyChart({Key? key, required this.groupsList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EnergyChartState();

  factory EnergyChart.buildChart(
      Map<String?, List<dynamic>> energyTypeMap, String period) {
    // ignore: unnecessary_new
    return new EnergyChart(groupsList: _createData(energyTypeMap, period));
  }

  static List<BarChartGroupData> _createData(
      Map<String?, List<dynamic>> energyTypeMap, String period) {
    List<BarChartGroupData> dataList = [];

    energyTypeMap.forEach((eType, values) {
      List<BarChartRodData> rodList = [];
      double val = values[getPeriodIndex(period)];
      if (val > 1000) {
        val = val / 1000;
      }
      if (val > 1000000) {
        val = val / 1000000;
      }
      if (val > 1000000000) {
        val = val / 1000000000;
      }
      var barChartRodData =
          BarChartRodData(toY: val, color: getSeriesColour(eType!));
      rodList.add(barChartRodData);
      dataList.add(BarChartGroupData(barRods: rodList, x: 0));
    });

    return dataList;
  }

  static getSeriesColour(String pType) {
    switch (pType) {
      case "pv":
        return Colors.green;
      case "load":
        return Colors.cyan;
      case "gridConsume":
        return Colors.red.shade700;
      case "gridFeed":
        return Colors.red.shade300;
      case "stCharge":
        return Colors.lime;
      case "stDischarge":
        return Colors.deepOrange;
      case "gen":
        return Colors.grey;
      default:
        return Colors.grey.shade200;
    }
  }

  static int getPeriodIndex(String selectedPeriod) {
    if (selectedPeriod == "daily") {
      return 0;
    }
    if (selectedPeriod == "weekly") {
      return 1;
    }
    if (selectedPeriod == "monthly") {
      return 2;
    }
    if (selectedPeriod == "yearly") {
      return 3;
    }
    if (selectedPeriod == "total") {
      return 4;
    }
    return 5;
  }
}

class EnergyChartState extends State<EnergyChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    rawBarGroups = widget.groupsList;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    double maxY = 0;
    for (var i = 0; i < widget.groupsList.length; i++) {
      for (var j = 0; j < widget.groupsList[i].barRods.length; j++) {
        if (widget.groupsList[i].barRods[j].toY > maxY) {
          maxY = widget.groupsList[i].barRods[j].toY;
        }
      }
    }

    if (maxY > 1000) {
      maxY = maxY / 1000;
    }
    if (maxY > 1000000) {
      maxY = maxY / 1000000;
    }
    if (maxY > 1000000000) {
      maxY = maxY / 1000000000;
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ChartDatePicker(
                  selectedDate:
                      Provider.of<EnergyChartManager>(context).selectedDateStr),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (_a, _b, _c, _d) => null,
                        ),
                        touchCallback: (FlTouchEvent event, response) {
                          // if (response == null || response.spot == null) {
                          //   setState(() {
                          //     touchedGroupIndex = -1;
                          //     showingBarGroups = List.of(rawBarGroups);
                          //   });
                          //   return;
                          // }

                          // touchedGroupIndex =
                          //     response.spot!.touchedBarGroupIndex;

                          // setState(() {
                          //   if (!event.isInterestedForInteractions) {
                          //     touchedGroupIndex = -1;
                          //     showingBarGroups = List.of(rawBarGroups);
                          //     return;
                          //   }
                          //   showingBarGroups = List.of(rawBarGroups);
                          //   if (touchedGroupIndex != -1) {
                          //     var sum = 0.0;
                          //     for (var rod
                          //         in showingBarGroups[touchedGroupIndex]
                          //             .barRods) {
                          //       sum += rod.toY;
                          //     }
                          //     final avg = sum /
                          //         showingBarGroups[touchedGroupIndex]
                          //             .barRods
                          //             .length;

                          //     showingBarGroups[touchedGroupIndex] =
                          //         showingBarGroups[touchedGroupIndex].copyWith(
                          //       barRods: showingBarGroups[touchedGroupIndex]
                          //           .barRods
                          //           .map((rod) {
                          //         return rod.copyWith(toY: avg);
                          //       }).toList(),
                          //     );
                          //   }
                          // });
                        }),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: maxY / 10,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    String text;
    if (value > 1000000) {
      text = (value / 1000000).toStringAsFixed(2);
    } else if (value > 1000) {
      text = (value / 1000).toStringAsFixed(2);
    } else {
      text = (value).toStringAsFixed(0);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    var getEnergyTypeMap =
        Provider.of<EnergyChartManager>(context).getEnergyTypeMap;

    List<String> titles = ["Mn", "Te", "Wd", "Tu", "Fr", "St", "Su"];

    Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
