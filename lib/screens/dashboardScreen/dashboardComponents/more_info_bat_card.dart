import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/websocket/es_manager.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/websocket/ps_manager.dart';
import 'battery_view.dart';

class BatCard extends StatefulWidget {
  const BatCard({Key? key}) : super(key: key);

  @override
  State<BatCard> createState() => _BatCardState();
}

class _BatCardState extends State<BatCard> {
  @override
  Widget build(BuildContext context) {
    final esManager = Provider.of<EnergyStorageServiceManager>(context);
    final batStorageLevel = esManager.sumData.capacityP;
    final batCurrent = esManager.sumData.currentA.toStringAsFixed(2);
    final batVoltage = esManager.sumData.voltageV.toStringAsFixed(2);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 10, 0),
                              child: Icon(
                                Icons.battery_charging_full,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                size: 16,
                              ),
                            ),
                            Text(
                              "State",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 11,
                                  ),
                            ),
                            Text(
                              '(batExport) kW',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: const Color(0xFF3999D2),
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 10, 0),
                                child: Icon(
                                  Icons.bolt,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: 15,
                                ),
                              ),
                              Text(
                                'Voltage',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 60,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                alignment: const AlignmentDirectional(
                                    -0.050000000000000044,
                                    -0.050000000000000044),
                                child: Text(
                                  batVoltage,
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Text(
                                'V',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 10, 0),
                                child: Icon(
                                  Icons.bolt,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: 15,
                                ),
                              ),
                              Text(
                                'Current',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 60,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                alignment: const AlignmentDirectional(
                                    -0.050000000000000044,
                                    -0.050000000000000044),
                                child: Text(
                                  batCurrent,
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Text(
                                'A',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 10, 0),
                                child: Icon(
                                  Icons.bolt,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: 15,
                                ),
                              ),
                              Text(
                                'Power',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 60,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                alignment: const AlignmentDirectional(
                                    -0.050000000000000044,
                                    -0.050000000000000044),
                                child: Text(
                                  esManager.sumData.powerW.toStringAsFixed(2),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Text(
                                'W',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 15, top: 16),
          child: Container(
            width: 50,
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFAACBCE).withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80.0),
                  bottomLeft: Radius.circular(80.0),
                  bottomRight: Radius.circular(80.0),
                  topRight: Radius.circular(80.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(2, 2),
                    blurRadius: 4),
              ],
            ),
            child: BatteryView(
              percentageValue: batStorageLevel, //batStorage,
              // percentageValue: 60,
            ),
          ),
        )
      ],
    );
  }
}
