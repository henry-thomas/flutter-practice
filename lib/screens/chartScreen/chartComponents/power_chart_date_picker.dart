import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/power_type_chart_manager.dart';

class PowerChartDatePicker extends StatelessWidget {
  const PowerChartDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 1,
          color: FlutterFlowTheme.of(context).secondaryColor,
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  Provider.of<PowerTypeChartDataManager>(context, listen: false)
                      .selectedDateStr,
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
          splashColor: FlutterFlowTheme.of(context).primaryBackground,
          onTap: () async {
            Provider.of<PowerTypeChartDataManager>(context, listen: false)
                .onDatePickerOpen(context);
          },
        ),
        Container(
          width: 120,
          height: 1,
          color: FlutterFlowTheme.of(context).secondaryColor,
        ),
      ],
    );
  }
}
