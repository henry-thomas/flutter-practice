/// Timeseries chart example
// ignore_for_file: unnecessary_new, duplicate_ignore, prefer_const_constructors

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';

import '../../entities/energy_storage_db.dart';
import '../../flutterFlow/flutter_flow_util.dart';
import 'chartComponents/chart_actions.dart';

class PowerTypeChart extends StatefulWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;

  const PowerTypeChart(this.seriesList, {Key? key, this.animate})
      : super(key: key);

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  // ignore: duplicate_ignore
  factory PowerTypeChart.buildChart(
      Map<String?, List<DevPowerSummary>> powerTypeMap,
      List<EnergyStorageDb> storageList) {
    // ignore: unnecessary_new
    return new PowerTypeChart(
      _createData(powerTypeMap, storageList),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  State<PowerTypeChart> createState() => _PowerTypeChartState();

  /// Create one series with sample hard coded data.
  static List<charts.Series<PowerTypeSeriesPoint, DateTime>> _createData(
      Map<String?, List<DevPowerSummary>> powerTypeMap,
      List<EnergyStorageDb> storageList) {
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

    //Adding energy Storages to the chart
    List<PowerTypeSeriesPoint> ptspList = [];
    for (var i = 0; i < storageList.length; i++) {
      if (storageList[i].lastUpdate != null) {
        PowerTypeSeriesPoint ptsp = PowerTypeSeriesPoint(
            storageList[i].lastUpdate!.toLocal(), storageList[i].capacityP);
        ptspList.add(ptsp);
      }
    }

    if (ptspList.isNotEmpty) {
      var series = new charts.Series(
        id: "Battery Capacity",
        data: ptspList,
        domainFn: (PowerTypeSeriesPoint ptsp, _) => ptsp.time,
        colorFn: (_, __) {
          return charts.MaterialPalette.yellow.shadeDefault.darker;
        },
        measureFn: (PowerTypeSeriesPoint ptsp, _) {
          return ptsp.value / 100;
        },
        strokeWidthPxFn: (datum, index) {
          return 4;
        },
      )

        //For some reason id has to be exactly this
        ..setAttribute(charts.measureAxisIdKey, "secondaryMeasureAxisId");
      serList.add(series);
    }

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

  List<ChartBehavior<DateTime>> behaviors = [];

  @override
  Widget build(BuildContext context) {
    var chartsActions = Provider.of<ChartActions>(context);
    bool isOpen = chartsActions.isPowerTypeChartMenuOpen;
    var chartHeight = MediaQuery.of(context).size.height * 0.7;
    var chartWidth = MediaQuery.of(context).size.width * 1;
    var fontSize = 11;
    var margin = 0;

    // setState(() {
    if (isOpen == false) {
      margin = 0;
      fontSize = 0;
      chartHeight = 70;
      chartWidth = 100;
      behaviors.remove(0);
    } else {
      fontSize = 11;
      margin = 15;
      chartHeight = MediaQuery.of(context).size.height * 0.7;
      chartWidth = MediaQuery.of(context).size.width * 1;
      if (behaviors.isEmpty) {
        behaviors.add(
          new charts.SeriesLegend(
            horizontalFirst: false,
            measureFormatter: (measure) {
              if (measure != null) {
                return ((measure / 1000).toStringAsFixed(2) + " kW");
              }
              return "";
            },
            position: charts.BehaviorPosition.bottom,
            showMeasures: true,
            secondaryMeasureFormatter: (measure) {
              if (measure != null) {
                return ((measure * 100).toStringAsFixed(2) + " %");
              }
              return "";
            },
          ),
        );
      }
    }
    // });
    // ignore: unnecessary_new
    final charts.NumericTickFormatterSpec simpleFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.compact());
    final charts.NumericTickFormatterSpec percFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.percentPattern());

    final children = <Widget>[
      SizedBox(
        height: chartHeight,
        width: chartWidth,
        child: charts.TimeSeriesChart(
          widget.seriesList,

          layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fixedPixel(0),
            rightMarginSpec: charts.MarginSpec.fixedPixel(0),
            bottomMarginSpec: charts.MarginSpec.fixedPixel(margin),
            topMarginSpec: charts.MarginSpec.fixedPixel(margin),
          ),

          primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                desiredTickCount: 5, zeroBound: false),
            tickFormatterSpec: simpleFormatter,
            renderSpec: charts.GridlineRendererSpec(
                labelJustification: charts.TickLabelJustification.outside,
                labelAnchor: charts.TickLabelAnchor.after,
                labelStyle: charts.TextStyleSpec(
                    fontSize: fontSize,
                    lineHeight: 0.2,
                    color: FlutterFlowTheme.of(context).chartLabelColor),
                labelOffsetFromAxisPx: -35),
            showAxisLine: false,
          ),

          secondaryMeasureAxis: new charts.PercentAxisSpec(
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                desiredTickCount: 5, zeroBound: false),
            tickFormatterSpec: percFormatter,
            renderSpec: charts.GridlineRendererSpec(
              labelJustification: charts.TickLabelJustification.outside,
              labelAnchor: charts.TickLabelAnchor.after,
              labelStyle: charts.TextStyleSpec(
                  fontSize: fontSize,
                  lineHeight: 0.2,
                  color: FlutterFlowTheme.of(context).chartLabelColor),
            ),
            showAxisLine: false,
          ),

          defaultRenderer: new charts.LineRendererConfig(
              includeArea: true, areaOpacity: 0.05),

          animate: widget.animate,
          defaultInteractions: true,

          domainAxis: new charts.DateTimeAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                  minimumPaddingBetweenLabelsPx: 1,
                  labelStyle: charts.TextStyleSpec(
                      fontSize: fontSize,
                      lineHeight: 1,
                      color: FlutterFlowTheme.of(context).chartLabelColor)),
              tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                  hour: new charts.TimeFormatterSpec(
                      format: 'HH:mm', transitionFormat: 'HH:mm'),
                  day: new charts.TimeFormatterSpec(
                      format: 'hh:mm', transitionFormat: 'HH:mm'))),

          // Optionally pass in a [DateTimeFactory] used by the chart. The factory
          // should create the same type of [DateTime] as the data provided. If none
          // specified, the default creates local date time.
          dateTimeFactory: const charts.LocalDateTimeFactory(),
          behaviors: behaviors,
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
