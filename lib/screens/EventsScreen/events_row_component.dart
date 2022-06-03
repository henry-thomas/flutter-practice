import 'package:flutter/material.dart';

import '../../flutterFlow/flutter_flow_theme.dart';

class EventsRow {
  Column getEventRow( level) {
    // if (icon == "info"){
    //   icon = Icon(
    //     Icons.info_outline_rounded,
    //     color: Colors.blueAccent,
    //     size: 24,
    //   );
    // }
   Icon icon = Icon(
     Icons.info_outline_rounded,
     color: Colors.blueAccent,
     size: 24,
   );
    switch (level) {
      case "info":
        level = "Info";
        icon = Icon(
          Icons.info_outline_rounded,
          color: Colors.blueAccent,
          size: 24,
        );
      break;
      case "warning":
        level = "Warning";
        icon = Icon(
          Icons.warning_rounded,
          color: Colors.orangeAccent,
          size: 24,
        );
        break;
      case "error":
        level = "Error";
        icon = Icon(
          Icons.error_rounded,
          color: Colors.redAccent,
          size: 24,
        );
        break;
      case "config_avd":
        level = "CONFIG_AVD";
        icon = Icon(
          Icons.warning_rounded,
          color: Colors.orangeAccent,
          size: 24,
        );
        break;
      case "config":
        level = "CONFIG";
        icon = Icon(
          Icons.warning_rounded,
          color: Colors.orangeAccent,
          size: 24,
        );
        break;
      case "debug":
        level = "Debug";
        icon = Icon(
          Icons.bug_report,
          color: Colors.green,
          size: 24,
        );
        break;
      case "trace":
        level = "Trace";
        icon = Icon(
          Icons.title_rounded,
          color: Colors.lightBlueAccent,
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
                    level,

                  ),
                ),
              ),

            ],
          ),
          Text(
            '22-05-13 04:18:49',

          ),

        ],
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 0.8,

          color: Colors.black45,
        ),
      )
    ],);
  }
}