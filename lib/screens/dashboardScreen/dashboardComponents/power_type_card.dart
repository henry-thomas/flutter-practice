import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/websocket/ps_manager.dart';
import 'dashboard_button_actions.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PowerInfoCard extends StatefulWidget {
  final String powerType;

  const PowerInfoCard({Key? key,
    required this.powerType,}) : super(key: key);

  @override
  State<PowerInfoCard> createState() => _PowerInfoCardState();
}
class _PowerInfoCardState extends State<PowerInfoCard> {
  @override
  Widget build(BuildContext context) {
    final psManager = Provider.of<PowerServiceManager>(context);
    String pvPower = (psManager.pvPower/1000).toStringAsFixed(2);
    String totalEnergy =  (psManager.pvTotalEnergy/1000).toStringAsFixed(2);
    String ratedPowerPercent = psManager.pvRatedPowerPercentageLevel.toStringAsFixed(0);
    Color cardColor = Colors.blue;
    Widget powerCardIcon = FaIcon(
      FontAwesomeIcons.circleDot,
      color:
      FlutterFlowTheme.of(context)
          .tertiaryColor,
      size: 15,
    );
    String dailyEnergy =  psManager.pvDailyEnergy.toStringAsFixed(2);
    String monthlyEnergy =  psManager.pvMonthlyEnergy.toStringAsFixed(2);
    String current =  psManager.pvCurrent.toStringAsFixed(2);
    String voltage = psManager.pvVoltage.toStringAsFixed(2);
    double ratedPowerPercentIndicator =  psManager.pvRatedPowerPercentageLevel / 100;



    switch (widget.powerType) {
      case "PV":
        cardColor = Colors.green;
        powerCardIcon = FaIcon(
          FontAwesomeIcons.solarPanel,
          color:
          FlutterFlowTheme.of(context)
              .tertiaryColor,
          size: 15,
        );
        dailyEnergy =  psManager.pvDailyEnergy.toStringAsFixed(2);
        monthlyEnergy = psManager.pvMonthlyEnergy.toStringAsFixed(2);
        totalEnergy = (psManager.pvTotalEnergy/1000).toStringAsFixed(2);
        current = psManager.pvCurrent.toStringAsFixed(2);
        voltage = psManager.pvVoltage.toStringAsFixed(2);
        ratedPowerPercent = psManager.pvRatedPowerPercentageLevel.toStringAsFixed(0);
        ratedPowerPercentIndicator =  psManager.pvRatedPowerPercentageLevel / 100;
        break;
      case "Grid":
        cardColor = Colors.red;
        powerCardIcon = Icon(
          Icons.offline_bolt_outlined,
          color:
          FlutterFlowTheme.of(context)
              .tertiaryColor,
          size: 25,
        );
        dailyEnergy =  psManager.gridDailyEnergy.toStringAsFixed(2);
        monthlyEnergy = psManager.gridMonthlyEnergy.toStringAsFixed(2);
        totalEnergy = (psManager.gridTotalEnergy/1000).toStringAsFixed(2);
        current = psManager.gridCurrent.toStringAsFixed(2);
        voltage = psManager.gridVoltage.toStringAsFixed(2);
        ratedPowerPercent = psManager.gridRatedPowerPercentageLevel.toStringAsFixed(0);
        ratedPowerPercentIndicator =  psManager.gridRatedPowerPercentageLevel / 100;
        break;
      case "Load":
        cardColor = Colors.blue;
        powerCardIcon = FaIcon(
          FontAwesomeIcons.house,
          color:
          FlutterFlowTheme.of(context)
              .tertiaryColor,
          size: 15,
        );

        dailyEnergy =  psManager.loadDailyEnergy.toStringAsFixed(2);
        monthlyEnergy = psManager.loadMonthlyEnergy.toStringAsFixed(2);
        totalEnergy = (psManager.loadTotalEnergy/1000).toStringAsFixed(2);
        current = psManager.loadCurrent.toStringAsFixed(2);
        voltage = psManager.loadVoltage.toStringAsFixed(2);
        ratedPowerPercent = psManager.loadRatedPowerPercentageLevel.toStringAsFixed(0);
        ratedPowerPercentIndicator =  psManager.loadRatedPowerPercentageLevel / 100;
        break;

      default:
    }



    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Container(
                width: 150,
                height: 75,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            "Daily",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 11,
                                    ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              dailyEnergy,
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'kWh',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                "Month",
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                              monthlyEnergy,
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'kWh',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                "Total",
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                              totalEnergy,
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                              child: Text(
                                'MWh',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Container(
                width: 150,
                height: 75,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 0),
                      child:Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(30)),
                          depth: 2,
                          lightSource: LightSource.top,
                          // shadowDarkColor: Colors.orange,
                          color: FlutterFlowTheme.of(context)
                              .primaryBackground,
                        ),
                        child: SizedBox(
                          width: 49,
                          height: 49,
                          child: Center(
                            child:powerCardIcon,
                          ),
                        ),
                      )
                    ),


                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pvPower,
                            style:
                            FlutterFlowTheme
                                .of(context)
                                .bodyText1,
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text(
                              'kW',
                              style: FlutterFlowTheme
                                  .of(context)
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme
                                    .of(context)
                                    .secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 310,
              height: 2,
              decoration: BoxDecoration(
                color:cardColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Container(
                width: 150,
                height: 63,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 0),
                              child: Text(
                                "Current",
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  color:
                                  FlutterFlowTheme
                                      .of(
                                      context)
                                      .secondaryText,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Text(
                              current,
                              style: FlutterFlowTheme
                                  .of(context)
                                  .bodyText1,
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 0),
                              child: Text(
                                'A',
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  color:
                                  FlutterFlowTheme
                                      .of(
                                      context)
                                      .secondaryText,
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
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 0),
                              child: Text(
                                "Voltage",
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  color:
                                  FlutterFlowTheme
                                      .of(
                                      context)
                                      .secondaryText,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Text(
                              voltage,
                              style: FlutterFlowTheme
                                  .of(context)
                                  .bodyText1,
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  3, 0, 0, 0),
                              child: Text(
                                'V',
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  color:
                                  FlutterFlowTheme
                                      .of(
                                      context)
                                      .secondaryText,
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
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Container(
                width: 150,
                height: 63,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                  child: CircularPercentIndicator(
                      percent:
                      ratedPowerPercentIndicator,
                      animation: false,
                      progressColor: cardColor,
                      backgroundColor:
                      cardColor.withOpacity(0.1),
                      radius: 30.0,
                      lineWidth: 8.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text("$ratedPowerPercent%",

                        style:
                        FlutterFlowTheme
                            .of(context)
                            .bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          color:
                          FlutterFlowTheme
                              .of(
                              context)
                              .secondaryText,
                          fontSize: 14,
                        ),)
                  ),
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
