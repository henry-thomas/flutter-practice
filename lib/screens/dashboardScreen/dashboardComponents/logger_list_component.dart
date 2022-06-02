import 'package:flutter/material.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class LoggerListComponent {


  InkWell renderLoggerListItems(context, sn, description) {

    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0x00EEEEEE),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: Image.asset(
                    'assets/images/Rectangle_12.png',
                    width: 60,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  width: 120,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    description,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ),
                Container(
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    sn,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                //   child: FaIcon(
                //     FontAwesomeIcons.solidCircle,
                //     color: color,
                //     size: 10,
                //   ),
                // ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 1,
              decoration: BoxDecoration(
                color: Color(0xFF3B486E),
                boxShadow: [
                  // BoxShadow(
                  //   color: Color(0xFFFAFDFA),
                  //   offset: Offset(2, 0),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // loggerSN = sn;
        //
        // // getLoggerStatus ();
        // // SolarMdData(). getLoggerStatus;
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return DashboardWidget(
        //     loggerData: SolarMdData().loggerList,
        //     // loggerStatus: SolarMdData().onlineLoggers,
        //     loggerStatus: LoadingPageWidget().getLoggerList(),
        //     selectedLoggerSerial:
        //     sn, //will get this form phone storage later (saving config)
        //   );
        // }));
      },
    );
  }


}