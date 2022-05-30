

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class weatherComponents extends StatefulWidget {
  const weatherComponents({Key? key}) : super(key: key);

  @override
  State<weatherComponents> createState() => _weatherComponentsState();
}

class _weatherComponentsState extends State<weatherComponents> {

  bool  switchValue = false;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Container(
              width: 70,
              child: Text(
                "Thursday",
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
                  fontSize: 13,
                ),
              ),
            ),
            FaIcon(
              FontAwesomeIcons.cloudShowersHeavy,
              color:FlutterFlowTheme.of(context).tertiaryColor,
              size: 20,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                  child: Container(
                      width: 50,
                      child: Column(children: [
                        Text(
                          "Max PV",
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
                            fontSize: 13,
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.solarPanel,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          size: 11,
                        ),
                      ],)

                  ),
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: LinearPercentIndicator(
                      percent:0.5,
                      // percent:1,
                      //gridRatedPowerPercentageLevel / 100,
                      width: 60,
                      lineHeight: 9,
                      animation: false,
                      progressColor:FlutterFlowTheme.of(context).weatherTimeColor?.withOpacity(0.7),
                      backgroundColor:
                      FlutterFlowTheme.of(context).weatherTimeColor?.withOpacity(0.2),
                      barRadius:
                      const Radius.circular(
                          3)),
                ),

              ],
            ),

            NeumorphicSwitch(
              value: switchValue,
              height: 20,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              },
            ),
          ]
      ),
    );
  }
}
