import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/websocket/ps_manager.dart';
import 'liveCharts/pv_live_chart.dart';

class DailyEnergyCard extends StatefulWidget {
  const DailyEnergyCard({Key? key}) : super(key: key);

  @override
  State<DailyEnergyCard> createState() => _DailyEnergyCardState();
}

 

class _DailyEnergyCardState extends State<DailyEnergyCard> {
  
  double pvIconOpacity = 1;
  Color pvIconColor = Colors.green;
  
  @override
  Widget build(BuildContext context) {
    final psManager = Provider.of<PowerServiceManager>(
      context,
    );
    pvIconOpacity = psManager.pvIconPositionOpacity;
    pvIconColor = psManager.pvIconColor;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 140,
                height: 30,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: FaIcon(
                        FontAwesomeIcons.solarPanel,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        size: 11,
                      ),
                    ),
                    Text(
                      'Daily PV',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 40,
                      height: 29,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      alignment: const AlignmentDirectional(
                          -0.050000000000000044, -0.050000000000000044),
                      child: Text(
                        psManager.pvDailyEnergy.toStringAsFixed(2),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Text(
                      'kWh',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 140,
                height: 30,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: Icon(
                        Icons.offline_bolt_outlined,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        size: 14,
                      ),
                    ),
                    Text(
                      'Daily Grid',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 40,
                      height: 29,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      alignment: const AlignmentDirectional(
                          -0.050000000000000044, -0.050000000000000044),
                      child: Text(
                        psManager.gridDailyEnergy.toStringAsFixed(2),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Text(
                      'kWh',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 140,
                height: 30,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: FaIcon(
                        FontAwesomeIcons.house,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        size: 11,
                      ),
                    ),

                    Text(
                      'Daily Load',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 40,
                      height: 29,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      alignment: const AlignmentDirectional(
                          -0.050000000000000044, -0.050000000000000044),
                      child: Text(
                        psManager.loadDailyEnergy.toStringAsFixed(2),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Text(
                      'kWh',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: 330,
          color: FlutterFlowTheme.of(context).secondaryText,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
              offset:  Offset(0, 0),
              child:  FaIcon(
                FontAwesomeIcons.solarPanel,
                color:pvIconColor.withOpacity(pvIconOpacity),
                size: 9,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 0),
              child: const Icon(
                Icons.offline_bolt_outlined,
                color:Colors.red,
                size: 12,
              ),
            ),
            Transform.translate(
              offset:  Offset(0, 0),
              child: const FaIcon(
                FontAwesomeIcons.house,
                color:Colors.blue,
                size: 9,
              ),
            ),
          ],
        ),
         LivePvChart()
      ],
    );
  }
}
