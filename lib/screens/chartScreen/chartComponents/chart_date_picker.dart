import 'package:flutter/material.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class ChartDatePicker extends StatelessWidget {
  final String selectedDate;
  final Function onTap;
  const ChartDatePicker({
    Key? key,
    required this.selectedDate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 3,
          color: FlutterFlowTheme.of(context).secondaryColor,
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  selectedDate,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 11,
                      ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24,
                )
              ],
            ),
          ),
          highlightColor: FlutterFlowTheme.of(context).primaryBackground,
          // splashColor: FlutterFlowTheme.of(context).primaryBackground,
          onTap: () {
            onTap(context);
          },
        ),
        Container(
          width: 80,
          height: 3,
          color: FlutterFlowTheme.of(context).secondaryColor,
        ),
      ],
    );
  }
}
