import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/energy_chart_manager.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: InkWell(
              child: Text("Yearly",
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 13,
                      )),
              // hoverColor: FlutterFlowTheme.of(context).primaryBackground,
              onTap: () {
                Provider.of<EnergyChartManager>(context, listen: false)
                    .setSelectdPeriod("yearly");
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: InkWell(
              child: Text(
                "Monthly",
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 13,
                    ),
              ),
              onTap: () {
                Provider.of<EnergyChartManager>(context, listen: false)
                    .setSelectdPeriod("monthly");
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: InkWell(
              child: Text(
                "Daily",
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 13,
                    ),
              ),
              onTap: () {
                Provider.of<EnergyChartManager>(context, listen: false)
                    .setSelectdPeriod("daily");
              },
            ),
          ),
        ],
      ),
    );
  }
}
