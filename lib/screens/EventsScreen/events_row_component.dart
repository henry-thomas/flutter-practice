import 'package:flutter/material.dart';

import '../../flutterFlow/flutter_flow_theme.dart';

class EventsRow {
  Column getEventRow(context, icon) {
    // if (icon == "info"){
    //   icon = Icon(
    //     Icons.info_outline_rounded,
    //     color: Colors.blueAccent,
    //     size: 24,
    //   );
    // }
    switch (icon) {
      case "info":
        icon = Icon(
          Icons.info_outline_rounded,
          color: Colors.blueAccent,
          size: 24,
        );
      break;
      case "warning":
        icon = Icon(
          Icons.warning_rounded,
          color: Colors.orangeAccent,
          size: 24,
        );
        break;
      case "error":
        icon = Icon(
          Icons.error_rounded,
          color: Colors.redAccent,
          size: 24,
        );
        break;
    }
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 100,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  child: Text(
                    'Axpert Ai',
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
              ),

              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 100,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  child: Text(
                    'Device Reconnected',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),

            ],
          ),
          Text(
            '22-05-13 04:18:49',
            style: FlutterFlowTheme.of(context).bodyText1,
          ),

        ],
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 0.8,
          width:MediaQuery.of(context).size.width * 0.95,
          color: Colors.black45,
        ),
      )
    ],);
  }
}