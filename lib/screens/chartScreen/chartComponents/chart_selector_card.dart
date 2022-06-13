import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../flutterFlow/flutter_flow_util.dart';
import '../../../providers/power_type_chart_manager.dart';
import '../power_type_chart.dart';
import 'chart_actions.dart';

class ChartMenuItem extends StatefulWidget {
  const ChartMenuItem({Key? key}) : super(key: key);

  @override
  State<ChartMenuItem> createState() => _ChartMenuItemState();
}

class _ChartMenuItemState extends State<ChartMenuItem> {
  bool powerChartVisibility = false;
  bool chartSnapShot = true;

   DateTime now = DateTime.now();
   // var lastUpdated = DateFormat("MMMM d").format(now);



  @override
  Widget build(BuildContext context) {
    var ptcdm = Provider.of<PowerTypeChartDataManager>(context);
    var eStorageList = ptcdm.getEStorageList;
    var powerTypeMap = ptcdm.getPowerTypeMap;
    var chartsActions = Provider.of<chartActions>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration:  BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground?.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
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
                  'Power Chart',
                  style: FlutterFlowTheme.of(context)
                      .bodyText1
                      .override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context)
                        .secondaryText,
                    fontSize: 11,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color:  FlutterFlowTheme.of(context)
                        .tertiaryColor,
                    size: 26,
                  ),
                  onTap: () {
                    chartsActions.menuOpen();
                    setState(() {
                      if (powerChartVisibility == false) {
                        powerChartVisibility = true;
                        chartSnapShot = false;
                      } else {
                        powerChartVisibility = false;
                        chartSnapShot = true;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible:chartSnapShot ,
            child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70,
                width: 100,
                child: PowerTypeChart.buildChart(powerTypeMap, eStorageList),
              ),

              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        'Last Updated:',
                        style: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context)
                              .secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5, 0, 0, 0),
                        child: Text(
                            DateFormat("MMMM d  hh:mm:ss").format(now).toString(),
                          style: FlutterFlowTheme.of(context).bodyText1,

                        ),
                      ),

                    ],
                  ),



                ],
              ),
            ],
          ),
          ),

          Visibility(
            visible: powerChartVisibility,
            child: PowerTypeChart.buildChart(powerTypeMap, eStorageList),
          )
        ],
      ),
    );
  }
}
