import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../flutterFlow/flutter_flow_theme.dart';
import '../../../../providers/websocket/ps_manager.dart';
import '../../../chartScreen/chartComponents/chart_actions.dart';

class LiveChart extends StatefulWidget {
  const LiveChart({Key? key}) : super(key: key);

  @override
  _LiveChartState createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  final Color pvColor = Colors.green;
  final Color gridColor = Colors.red;
  final Color loadColor = Colors.blue;

  final limitCount = 100;
  final sinPoints = <FlSpot>[];
  final cosPoints = <FlSpot>[];

  final Map<String, List<FlSpot>> seriesNameSpotMap = {};

  final List<LineChartBarData> seriesList = [];

  List powerList = [];

  // final pvPowerPoints = <FlSpot>[];
  // final gridPowerPoints = <FlSpot>[];
  // final loadPowerPoints = <FlSpot>[];

  double xValue = 1;
  double step = 0.05;
  double absMax = 0;
  double startX = 0;
  double endX = 1;
  int currentDataCount = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      // while (currentDataCount > limitCount) {
      //   seriesNameSpotMap.forEach((serName, spotList) {
      //     spotList.removeAt(0);
      //   });
      // }
      setState(() {
        // sinPoints.add(FlSpot(xValue, math.sin(xValue)));
        // cosPoints.add(FlSpot(xValue, math.cos(xValue)));
      });
      xValue += step;
      currentDataCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final psManager = Provider.of<PowerServiceManager>(context);
    var getLivePowerTypeMap = psManager.getLivePowerTypeMap;
    powerList.clear();
    getLivePowerTypeMap.forEach((pType, devPower) {
      if (pType != "other" && pType != "grid") {
        if (!seriesNameSpotMap.containsKey(pType)) {
          seriesNameSpotMap.putIfAbsent(pType!, () => <FlSpot>[]);
          seriesList.add(addSeriesData(seriesNameSpotMap[pType]!, pType));
        }
        powerList.add(devPower.powerW);
        seriesNameSpotMap[pType]!.add(FlSpot(xValue, devPower.powerW));
        startX = seriesNameSpotMap[pType]!.first.x;
        endX = seriesNameSpotMap[pType]!.last.x;
      }
    });

    var chartsActions = Provider.of<ChartActions>(context);
    bool isOpen = chartsActions.isLiveChartMenuOpen;
    var chartHeight = MediaQuery.of(context).size.height * 0.7;
    var chartWidth = MediaQuery.of(context).size.width * 1;
    if (isOpen == false) {
      chartHeight = 70;
      chartWidth = 100;
    } else {
      chartHeight = MediaQuery.of(context).size.height * 0.7;
      chartWidth = MediaQuery.of(context).size.width * 1;
    }

    var maxY = powerList.reduce((curr, next) => curr > next ? curr : next);

    if (maxY > absMax) {
      absMax = maxY;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: chartHeight,
          width: chartWidth,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: absMax + absMax * 0.3,
              minX: startX,
              maxX: endX,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(

                    // maxContentWidth: 100,
                    tooltipBgColor: FlutterFlowTheme.of(context)
                        .loadingBoxColor
                        ?.withOpacity(0.2),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final textStyle = TextStyle(
                          color: touchedSpot.bar.gradient?.colors[1],
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        );
                        if (isOpen) {
                          return LineTooltipItem(

                              // ${touchedSpot.x.toStringAsFixed(0)}

                              '${getSerName(touchedSpot.bar.gradient?.colors[1])}: ${(touchedSpot.y / 1000).toStringAsFixed(2)} kW',
                              textStyle);
                        }
                      }).toList();
                    }),
                handleBuiltInTouches: true,
                getTouchLineStart: (data, index) => 0,
              ),
              clipData: FlClipData.all(),
              gridData: FlGridData(show: true, drawVerticalLine: false),
              lineBarsData: seriesList,
              titlesData: FlTitlesData(
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: isOpen,
                          getTitlesWidget: (value, meta) => Text(
                              (value / 1000).toStringAsFixed(1) + "kW",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 11,
                                  )),
                          // (value / 1000).toStringAsFixed(1) + "kW")

                          reservedSize: absMax.toStringAsFixed(1).length * 7))),
            ),
          ),
        )
      ],
    );
  }

  LineChartBarData addSeriesData(List<FlSpot> points, String pType) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
          colors: [
            getSeriesColor(pType).withOpacity(0.1),
            getSeriesColor(pType),
            getSeriesColor(pType)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 1.0, 1.0]),
      barWidth: 2,
      isCurved: false,
    );
  }

  static Color getSeriesColor(pType) {
    switch (pType) {
      case "pv":
        return Colors.green;
      case "load":
        return Colors.blue;
      case "gridConsume":
      case "grid":
        return Colors.red;
      case "gridFeed":
        return const Color.fromARGB(255, 182, 36, 25);
      case "stCharge":
        return const Color.fromARGB(255, 238, 143, 0);
      case "stDischarge":
        return const Color.fromARGB(255, 204, 123, 2);
      case "gen":
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  static String getSerName(Color? color) {
    if (color?.value == Colors.green.value) {
      return "PV";
    }
    if (color?.value == Colors.blue.value) {
      return "Load";
    }
    if (color?.value == Colors.red.value) {
      return "Grid";
    }
    if (color?.value == const Color.fromARGB(255, 182, 36, 25).value) {
      return "Grid Exp";
    }
    if (color?.value == const Color.fromARGB(255, 238, 143, 0).value) {
      return "Bat Ch";
    }
    if (color?.value == const Color.fromARGB(255, 204, 123, 2).value) {
      return "Bat Disch";
    }
    if (color?.value == Colors.grey.value) {
      return "Gen";
    }
    return "";
  }

  static String getReadablePowerTypeName(String pType) {
    switch (pType) {
      case "pv":
        return "PV";
      case "load":
        return "Load";
      case "gridConsume":
        return "Grid";
      case "gridFeed":
        return "Grid Export";
      case "stCharge":
        return "Storage Charge";
      case "stDischarge":
        return "Storage Discharge";
      case "gen":
        return "Generator";
      default:
        return "Other";
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
