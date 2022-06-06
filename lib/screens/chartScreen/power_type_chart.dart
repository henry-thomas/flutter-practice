/// Timeseries chart example
// ignore_for_file: unnecessary_new, duplicate_ignore, prefer_const_constructors

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider_test/entities/dev_power_summary.dart';

class PowerTypeChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;

  const PowerTypeChart(this.seriesList, {Key? key, this.animate})
      : super(key: key);

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  // ignore: duplicate_ignore
  factory PowerTypeChart.buildChart(
      Map<String?, List<DevPowerSummary>> powerTypeMap) {
    // ignore: unnecessary_new

    return new PowerTypeChart(
      _createData(powerTypeMap),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return SizedBox(
      height: 500,
      child: charts.TimeSeriesChart(
        seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, areaOpacity: 0.1),
        animate: animate,
        defaultInteractions: true,

        // customSeriesRenderers: [
        //   new charts.LineRendererConfig(
        //       includeArea: true, areaOpacity: 0.1, customRendererId: 'pv'),
        //   new charts.LineRendererConfig(
        //       includeArea: true, areaOpacity: 0.1, customRendererId: 'load'),
        // ],
        domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                hour: new charts.TimeFormatterSpec(
                    format: 'hh:mm', transitionFormat: 'MM/dd hh:mm'),
                day: new charts.TimeFormatterSpec(
                    format: 'MM/dd hh:mm',
                    transitionFormat: 'MM/dd/yyyy hh:mm'))),

        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        behaviors: [
          new charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
          ),
          // insideJustification: charts.InsideJustification.),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PowerTypeSeriesPoint, DateTime>> _createData(
      Map<String?, List<DevPowerSummary>> powerTypeMap) {
    List<charts.Series<PowerTypeSeriesPoint, DateTime>> serList = [];

    powerTypeMap.forEach((pType, powerList) {
      debugPrint(pType);
      List<PowerTypeSeriesPoint> ptspList = [];

      bool isExist = false;
      for (var i = 0; i < powerList.length; i++) {
        for (var powerTypeSeriesPoint in ptspList) {
          {
            if (powerTypeSeriesPoint.time ==
                DateTime.fromMillisecondsSinceEpoch(powerList[i].lastUpdate)) {
              powerTypeSeriesPoint.value += powerList[i].powerW;
              isExist = true;
              break;
            }
          }
        }
        if (!isExist) {
          ptspList.add(new PowerTypeSeriesPoint(
              DateTime.fromMillisecondsSinceEpoch(powerList[i].lastUpdate),
              powerList[i].powerW));
        }
      }

      if (pType != null) {
        var series = new charts.Series(
            id: pType,
            data: ptspList,
            domainFn: (PowerTypeSeriesPoint ptsp, _) => ptsp.time,
            colorFn: (_, __) {
              switch (pType) {
                case "pv":
                  return charts.MaterialPalette.green.shadeDefault;
                case "load":
                  return charts.MaterialPalette.cyan.shadeDefault;
                case "gridConsume":
                  return charts.MaterialPalette.red.shadeDefault.darker;
                case "gridFeed":
                  return charts.MaterialPalette.red.shadeDefault.lighter;
                case "stCharge":
                  return charts.MaterialPalette.lime.shadeDefault;
                case "stDischarge":
                  return charts.MaterialPalette.deepOrange.shadeDefault;
                case "gen":
                  return charts.MaterialPalette.gray.shadeDefault;
                default:
                  return charts.MaterialPalette.gray.shadeDefault.lighter;
              }
            },
            measureFn: (PowerTypeSeriesPoint ptsp, _) => ptsp.value);
        serList.add(series);
      }
    });
    return serList;
  }
}

/// Sample time series data type.
class PowerTypeSeriesPoint {
  DateTime time;
  double value;

  PowerTypeSeriesPoint(this.time, this.value);
}
