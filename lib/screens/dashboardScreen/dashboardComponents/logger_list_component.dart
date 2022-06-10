import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/entities/logger.dart';
import 'package:provider_test/providers/device_manager.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class LoggerListComponent {
  void _onLoggerSelected(BuildContext context, String serNum) {
    Provider.of<DeviceManager>(context, listen: false)
        .setSelectedLogger(context, serNum);
  }

  InkWell renderLoggerListItems(context, sn, description) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // height: 100,
        decoration: BoxDecoration(
          color: Color(0x00EEEEEE),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
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
        _onLoggerSelected(context, sn);
        Navigator.pop(context);
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
