import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'entities/dev_power_summary.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key, required this.powerTypeMap})
      : super(key: key);
  final Map<String?, List<DevPowerSummary>> powerTypeMap;

  @override
  _LineChartSample2State createState() => _LineChartSample2State(powerTypeMap);
}

class _LineChartSample2State extends State<LineChartSample2> {
  _LineChartSample2State(this.powerTypeMap);
  final powerTypeMap;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        LineChart(
          mainData(),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.black.withOpacity(0.5) : Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    DateFormat format = DateFormat('hh:mm');
    String formatted = format.format(dateTime);
    Widget text = Text(formatted);
    // switch (value.toInt()) {
    //   case 2:
    //     text = const Text('MAR', style: style);
    //     break;
    //   case 5:
    //     text = const Text('JUN', style: style);
    //     break;
    //   case 8:
    //     text = const Text('SEP', style: style);
    //     break;
    //   default:
    //     text = const Text('', style: style);
    //     break;
    // }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text =
        DateTime.fromMillisecondsSinceEpoch(value.toInt()).toIso8601String();
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
        // gridData: FlGridData(
        //   show: true,
        //   drawVerticalLine: false,
        //   horizontalInterval: 1,
        //   verticalInterval: 1,
        //   getDrawingHorizontalLine: (value) {
        //     return FlLine(
        //       color: const Color.fromARGB(255, 169, 171, 173),
        //       strokeWidth: 0.5,
        //     );
        //   },
        //   getDrawingVerticalLine: (value) {
        //     return FlLine(
        //       color: const Color(0xff37434d),
        //       strokeWidth: 1,
        //     );
        //   },
        // ),
        // titlesData: FlTitlesData(
        //   show: true,
        //   rightTitles: AxisTitles(
        //     sideTitles: SideTitles(showTitles: false),
        //   ),
        //   topTitles: AxisTitles(
        //     sideTitles: SideTitles(showTitles: false),
        //   ),
        //   bottomTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       reservedSize: 30,
        //       interval: 1,
        //       getTitlesWidget: bottomTitleWidgets,
        //     ),
        //   ),
        //   leftTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       interval: 1,
        //       getTitlesWidget: leftTitleWidgets,
        //       reservedSize: 42,
        //     ),
        //   ),
        // ),
        // borderData: FlBorderData(
        //     show: true,
        //     border: Border.all(color: const Color(0xff37434d), width: 1)),
        // minX: 0,
        // maxX: 999999999999999,
        // minY: 0,
        // maxY: 50000,
        lineBarsData: _createSampleData());
  }

  LineChartData avgData() {
    return LineChartData(
        // lineTouchData: LineTouchData(enabled: false),
        // gridData: FlGridData(
        //   show: true,
        //   drawHorizontalLine: true,
        //   verticalInterval: 1,
        //   horizontalInterval: 1,
        //   getDrawingVerticalLine: (value) {
        //     return FlLine(
        //       color: const Color(0xff37434d),
        //       strokeWidth: 1,
        //     );
        //   },
        //   getDrawingHorizontalLine: (value) {
        //     return FlLine(
        //       color: const Color(0xff37434d),
        //       strokeWidth: 1,
        //     );
        //   },
        // ),
        // titlesData: FlTitlesData(
        //   show: true,
        //   bottomTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       reservedSize: 30,
        //       getTitlesWidget: bottomTitleWidgets,
        //       interval: 1,
        //     ),
        //   ),
        //   leftTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       getTitlesWidget: leftTitleWidgets,
        //       reservedSize: 42,
        //       interval: 1,
        //     ),
        //   ),
        //   topTitles: AxisTitles(
        //     sideTitles: SideTitles(showTitles: false),
        //   ),
        //   rightTitles: AxisTitles(
        //     sideTitles: SideTitles(showTitles: false),
        //   ),
        // ),
        // borderData: FlBorderData(
        //     show: true,
        //     border: Border.all(color: const Color(0xff37434d), width: 1)),
        // minX: 0,
        // maxX: 11,
        // minY: 0,
        // maxY: 6,
        lineBarsData: _createSampleData());
  }

  List<LineChartBarData> _createSampleData() {
    List<LineChartBarData> seriesList = [];

    powerTypeMap.forEach((pType, powerList) {
      debugPrint(pType);
      List<PowerTypeSeriesPoint> ptspList = [];

      bool isExist = false;
      for (var i = 0; i < powerList.length; i++) {
        for (var powerTypeSeriesPoint in ptspList) {
          {
            if (powerTypeSeriesPoint.time == powerList[i].lastUpdate) {
              powerTypeSeriesPoint.value += powerList[i].powerW;
              isExist = true;
              break;
            }
          }
        }
        if (!isExist) {
          ptspList.add(PowerTypeSeriesPoint(
              powerList[i].lastUpdate, powerList[i].powerW));
        }
      }

      if (pType != null) {
        List<FlSpot> seriesData = [];
        for (int i = 0; i < ptspList.length; i++) {
          seriesData.add(FlSpot(
              ptspList[i].time.toDouble(), ptspList[i].value.toDouble()));
        }
        var lineChartBarData = LineChartBarData(
          spots: seriesData,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        );
        seriesList.add(lineChartBarData);
      }
    });
    return seriesList;
  }
}

class PowerTypeSeriesPoint {
  num time;
  num value;

  PowerTypeSeriesPoint(this.time, this.value);
}
