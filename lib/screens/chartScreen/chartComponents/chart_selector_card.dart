import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../flutterFlow/flutter_flow_util.dart';
import '../../../providers/power_type_chart_manager.dart';
import '../power_type_chart.dart';
import 'chart_actions.dart';

class ChartMenuItem extends StatefulWidget {
  final Widget chart;
  final String heading;
  final Function onTabCb;
  final List<Widget> infoWgtList;

  const ChartMenuItem(
      {Key? key,
      required this.chart,
      required this.heading,
      required this.onTabCb,
      required this.infoWgtList})
      : super(key: key);

  @override
  State<ChartMenuItem> createState() => _ChartMenuItemState();
}

class _ChartMenuItemState extends State<ChartMenuItem> {
  bool isOpen = false;
  bool chartSnapShot = true;

  @override
  Widget build(BuildContext context) {
    // var ptcdm = Provider.of<PowerTypeChartDataManager>(context);
    // var eStorageList = ptcdm.getEStorageList;
    // var powerTypeMap = ptcdm.getPowerTypeMap;
    var chartsActions = Provider.of<ChartActions>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color:
            FlutterFlowTheme.of(context).secondaryBackground?.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.heading,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 11,
                      ),
                ),
                InkWell(
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    size: 26,
                  ),
                  onTap: () {
                    widget.onTabCb();
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isOpen,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 70,
                  width: 100,
                  child: widget.chart,
                ),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    children: widget.infoWgtList),
              ],
            ),
          ),
          Visibility(
            visible: isOpen,
            child: widget.chart,
          )
        ],
      ),
    );
  }
}
