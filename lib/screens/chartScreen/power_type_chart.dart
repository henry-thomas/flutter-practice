/// Timeseries chart example
// ignore_for_file: unnecessary_new, duplicate_ignore, prefer_const_constructors

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider_test/entities/dev_power_summary.dart';

import '../../flutterFlow/flutter_flow_util.dart';

class PowerTypeChart extends StatefulWidget {
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
  State<PowerTypeChart> createState() => _PowerTypeChartState();

  /// Create one series with sample hard coded data.
  static List<charts.Series<PowerTypeSeriesPoint, DateTime>> _createData(
      Map<String?, List<DevPowerSummary>> powerTypeMap) {
    List<charts.Series<PowerTypeSeriesPoint, DateTime>> serList = [];

    powerTypeMap.forEach((pType, powerList) {
      if (pType != 'other') {
        List<PowerTypeSeriesPoint> ptspList = [];

        bool isExist = false;
        for (var i = 0; i < powerList.length; i++) {
          for (var powerTypeSeriesPoint in ptspList) {
            {
              if (powerTypeSeriesPoint.time ==
                  DateTime.fromMillisecondsSinceEpoch(
                      powerList[i].lastUpdate)) {
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
          if (powerList[i].lastUpdate == 0) {
            debugPrint(powerList[i].lastUpdate.toString());
          }
        }

        if (pType != null) {
          var series = new charts.Series(
              id: getReadablePowerTypeName(pType),
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
              measureFn: (PowerTypeSeriesPoint ptsp, _) {
                return ptsp.value;
              });
          serList.add(series);
        }
      }
    });
    return serList;
  }

  // static

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
}

class _PowerTypeChartState extends State<PowerTypeChart> {
  DateTime? _time;
  Map<String, double> _measures = {};

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime? time;
    Map<String, double> measures = {};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName!] = datumPair.datum.sales;
      });
    }

    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new

    final charts.NumericTickFormatterSpec simpleCurrencyFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.compact());

    final children = <Widget>[
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 1,
        child: charts.TimeSeriesChart(
          widget.seriesList,

          primaryMeasureAxis: new charts.NumericAxisSpec(
              tickFormatterSpec: simpleCurrencyFormatter),

          defaultRenderer: new charts.LineRendererConfig(
              includeArea: true, areaOpacity: 0.1),

          animate: widget.animate,
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
                horizontalFirst: false,
                measureFormatter: (measure) {
                  return (measure! / 1000).toStringAsFixed(2) + 'kW';
                },
                position: charts.BehaviorPosition.bottom,
                showMeasures: true),

            // insideJustification: charts.InsideJustification.),
          ],
        ),
      )
    ];
    return new Column(children: children);
  }
}

/// Sample time series data type.
class PowerTypeSeriesPoint {
  DateTime time;
  double value;

  PowerTypeSeriesPoint(this.time, this.value);
}
