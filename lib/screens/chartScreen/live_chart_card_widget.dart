import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../flutterFlow/flutter_flow_theme.dart';
import '../../providers/websocket/ps_manager.dart';
import '../dashboardScreen/dashboardComponents/liveCharts/live_chart.dart';
import 'chartComponents/chart_actions.dart';
import 'chartComponents/chart_selector_card.dart';

class LiveChartCard extends StatelessWidget {
  const LiveChartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChartMenuItem(
      chart: const LiveChart(),
      heading: "Live Chart",
      onTabCb: Provider.of<ChartActions>(context).liveChartMenuOpen,
      infoWgtList: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Text(
                        "Grid Power",
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (Provider.of<PowerServiceManager>(context).gridPower /
                              1000)
                          .toStringAsFixed(2),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.red.withOpacity(0.5),
                            fontSize: 14,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                      child: Text(
                        'kW',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Text(
                        "Load Power",
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (Provider.of<PowerServiceManager>(context).loadPower /
                              1000)
                          .toStringAsFixed(2),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.blue.withOpacity(0.5),
                            fontSize: 14,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                      child: Text(
                        'kW',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Text(
                        "Pv Power",
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (Provider.of<PowerServiceManager>(context).pvPower / 1000)
                          .toStringAsFixed(2),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.green.withOpacity(0.5),
                            fontSize: 14,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                      child: Text(
                        'kW',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
