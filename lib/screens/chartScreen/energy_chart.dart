import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/energy_chart_manager.dart';
import 'package:provider_test/screens/chartScreen/chartComponents/chart_date_picker.dart';
import 'package:provider_test/screens/chartScreen/chartComponents/period_selector.dart';

import '../../flutterFlow/flutter_flow_theme.dart';
import 'chartComponents/chart_actions.dart';

class EnergyChart extends StatefulWidget {
  final List<BarChartGroupData> groupsList;
  final String period;
  final Map<String?, List<dynamic>> energyTypeMap;

  const EnergyChart(
      {Key? key,
      required this.groupsList,
      required this.period,
      required this.energyTypeMap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => EnergyChartState();

  factory EnergyChart.buildChart(
      Map<String?, List<dynamic>> energyTypeMap, String period) {
    return EnergyChart(
      energyTypeMap: energyTypeMap,
      groupsList: _createData(energyTypeMap, period),
      period: period,
    );
  }

  static List<BarChartGroupData> _createData(
      Map<String?, List<dynamic>> energyTypeMap, String period) {
    List<BarChartGroupData> dataList = [];
    int x = 0;
    energyTypeMap.forEach((eType, values) {
      if (eType != 'other') {
        List<BarChartRodData> rodList = [];
        double val = values[getPeriodIndex(period)];
        var barChartRodData =
            BarChartRodData(toY: val, color: getSeriesColour(eType!), width: 8);
        rodList.add(barChartRodData);
        dataList.add(BarChartGroupData(barRods: rodList, x: x));
        x++;
      }
    });

    return dataList;
  }

  static getSeriesColour(String pType) {
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
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    var chartsActions = Provider.of<ChartActions>(context);
    bool isOpen = chartsActions.isEnergyTypeChartMenuOpen;

    double maxY = 0;
    for (var i = 0; i < widget.groupsList.length; i++) {
      for (var j = 0; j < widget.groupsList[i].barRods.length; j++) {
        if (widget.groupsList[i].barRods[j].toY > maxY) {
          maxY = widget.groupsList[i].barRods[j].toY;
        }
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Visibility(
            visible: isOpen,
            child: ChartDatePicker(
                selectedDate:
                    Provider.of<EnergyChartManager>(context).selectedDateStr,
                onTap: Provider.of<EnergyChartManager>(context, listen: false)
                    .onDatePickerOpen),
          ),
          Visibility(visible: isOpen, child: PeriodSelector()),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: maxY + maxY * 0.2,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: FlutterFlowTheme.of(context)
                          .loadingBoxColor
                          ?.withOpacity(0.2),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        if (isOpen) {
                          return BarTooltipItem(
                            widget.period.toUpperCase() + '\n',
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 11,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: (rod.toY / 1000).toStringAsFixed(1) +
                                    " kWh",
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          );
                        }
                      }),
                ),
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
                      showTitles: isOpen,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: isOpen,
                    reservedSize: maxY.toStringAsFixed(1).length * 8,
                    interval: maxY / 4,
                    getTitlesWidget: leftTitles,
                  )),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: widget.groupsList,
                gridData: FlGridData(show: true, horizontalInterval: maxY / 5),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    var textWidget = Text((value / 1000).toStringAsFixed(1) + " kWh",
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 11,
            ));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: textWidget,
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> titles = [];

    widget.energyTypeMap.forEach((key, value) {
      if (key != 'other') {
        titles.add(key.toString());
      }
    });

    Widget text = Text(
      getReadablePowerTypeName(titles[value.toInt()]),
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.of(context).secondaryText,
            fontSize: 11,
          ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  String getReadablePowerTypeName(String pType) {
    switch (pType) {
      case "pv":
        return "PV";
      case "load":
        return "Load";
      case "gridConsume":
        return "Grid";
      case "gridFeed":
        return "Grid Exp";
      case "stCharge":
        return "Charge";
      case "stDischarge":
        return "Discharge";
      case "gen":
        return "Gen";
      default:
        return "Other";
    }
  }
}
