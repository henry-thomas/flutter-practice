import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../flutterFlow/flutter_flow_theme.dart';
import '../../../../providers/websocket/ps_manager.dart';
import '../../../chartScreen/chartComponents/chart_actions.dart';

class LivePvChart extends StatefulWidget {
  const LivePvChart({Key? key}) : super(key: key);

  @override
  _LivePvChartState createState() => _LivePvChartState();
}

class _LivePvChartState extends State<LivePvChart> {
  final Color pvColor = Colors.green;
  final Color gridColor = Colors.red;
  final Color loadColor = Colors.blue;

  final limitCount = 100;
  final sinPoints = <FlSpot>[];
  final cosPoints = <FlSpot>[];

  final pvPowerPoints = <FlSpot>[];
  final gridPowerPoints = <FlSpot>[];
  final loadPowerPoints = <FlSpot>[];

  addPowerPoints(pvPower, gridPower, loadPower) {
    pvPowerPoints.add(FlSpot(xValue, pvPower));
    gridPowerPoints.add(FlSpot(xValue, gridPower));
    loadPowerPoints.add(FlSpot(xValue, loadPower));
  }

  double xValue = 1;
  double step = 0.05;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      while (sinPoints.length > limitCount) {
        sinPoints.removeAt(0);
        cosPoints.removeAt(0);
      }
      setState(() {
        sinPoints.add(FlSpot(xValue, math.sin(xValue)));
        cosPoints.add(FlSpot(xValue, math.cos(xValue)));
      });
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    final psManager = Provider.of<PowerServiceManager>(context);
    final pvRatedPower = psManager.pvRatedPower;
    final loadRatedPower = psManager.loadRatedPower;
    final gridRatedPower = psManager.gridRatedPower;
    var chartsActions = Provider.of<chartActions>(context);
    bool isOpen = chartsActions.liveChartMenuIsOpen;
    var chartHeight = MediaQuery.of(context).size.height * 0.7;
    var chartWidth = MediaQuery.of(context).size.width * 1;
    if (isOpen == false) {
      chartHeight = 70;
      chartWidth = 100;
    }else {
      chartHeight = MediaQuery.of(context).size.height * 0.7;
      chartWidth =MediaQuery.of(context).size.width * 1;
    }

    List highestRatedPower = [pvRatedPower, loadRatedPower, gridRatedPower];
    var maxY =
        highestRatedPower.reduce((curr, next) => curr > next ? curr : next);
    final pvPower = psManager.pvPower;
    final gridPower = psManager.gridPower;
    final loadPower = psManager.loadPower;
    addPowerPoints(pvPower, gridPower, loadPower);
    return cosPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: chartHeight,
                width: chartWidth,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: maxY,
                    minX: pvPowerPoints.first.x,
                    maxX: pvPowerPoints.last.x,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                          maxContentWidth: 100,
                          tooltipBgColor: FlutterFlowTheme.of(context)
                              .loadingBoxColor
                              ?.withOpacity(0.7),
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((LineBarSpot touchedSpot) {
                              final textStyle = TextStyle(
                                color: touchedSpot.bar.gradient?.colors[1],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              );
                              return LineTooltipItem(

                                  // ${touchedSpot.x.toStringAsFixed(0)}
                                  ' ${(touchedSpot.y / 1000).toStringAsFixed(2)} kW',
                                  textStyle);
                            }).toList();
                          }),
                      handleBuiltInTouches: true,
                      getTouchLineStart: (data, index) => 0,
                    ),
                    clipData: FlClipData.all(),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                    ),
                    lineBarsData: [
                      sinLine(pvPowerPoints),
                      cosLine(gridPowerPoints),
                      laodLine(loadPowerPoints),
                    ],
                    titlesData: FlTitlesData(
                      show: false,

                      // topTitles: AxisTitles(),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  LineChartBarData sinLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
          colors: [pvColor.withOpacity(0), pvColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 1.0]),
      barWidth: 1.5,
      isCurved: true,
    );
  }

  LineChartBarData cosLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
          colors: [gridColor.withOpacity(0), gridColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 1.0]),
      barWidth: 1.5,
      isCurved: true,
    );
  }

  LineChartBarData laodLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
          colors: [loadColor.withOpacity(0), loadColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 1.0]),
      barWidth: 1.5,
      isCurved: true,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
