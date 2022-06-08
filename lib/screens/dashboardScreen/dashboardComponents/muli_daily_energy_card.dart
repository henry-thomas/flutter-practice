import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/dash_info_data_field.dart';
import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/websocket/ps_manager.dart';

class DailyEnergyCard extends StatefulWidget {
  const DailyEnergyCard({Key? key}) : super(key: key);

  @override
  State<DailyEnergyCard> createState() => _DailyEnergyCardState();
}

class _DailyEnergyCardState extends State<DailyEnergyCard> {
  double pvIconOpacity = 1;
  Color pvIconColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    final psManager = Provider.of<PowerServiceManager>(
      context,
    );
    pvIconOpacity = psManager.pvIconPositionOpacity;
    pvIconColor = psManager.pvIconColor;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DashInfoDFWidget(
              value: psManager.pvDailyEnergy,
              unit: "kWh",
              label: 'Daily PV',
              icon: FaIcon(
                FontAwesomeIcons.solarPanel,
                color: FlutterFlowTheme.of(context).tertiaryColor,
                size: 11,
              )),
          DashInfoDFWidget(
              value: psManager.gridDailyEnergy,
              unit: "kWh",
              label: 'Daily Grid',
              icon: Icon(
                Icons.offline_bolt_outlined,
                color: FlutterFlowTheme.of(context).tertiaryColor,
                size: 14,
              )),
          DashInfoDFWidget(
              value: psManager.loadDailyEnergy,
              unit: "kWh",
              label: 'Daily Load',
              icon: FaIcon(
                FontAwesomeIcons.house,
                color: FlutterFlowTheme.of(context).tertiaryColor,
                size: 11,
              )),
          // Container(
          //   height: 1,
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   color: FlutterFlowTheme.of(context).secondaryText,
          // ),
        ],
      ),
    );
  }
}
