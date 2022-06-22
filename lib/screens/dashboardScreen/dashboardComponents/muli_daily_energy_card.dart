import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/websocket/ps_manager.dart';
import 'dash_info_data_field.dart';
import 'liveCharts/live_chart.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        color: const Color(0x00EEEEEE),
        // backgroundBlendMode: BlendMode.src,
        image: DecorationImage(
          fit: BoxFit.fitHeight,

          image: Image.asset(
            'assets/images/rect1405.png',
          ).image,
          // opacity: 0.5
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DashInfoDFWidget(
                label: "CO2 reduced",
                icon: FaIcon(
                  FontAwesomeIcons.cloudMeatball,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 14,
                ),
                unit: "kg",
                value: psManager.c02Reduced),
            DashInfoDFWidget(
                label: 'Electric Car Trip',
                icon: Icon(
                  Icons.electric_car,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 14,
                ),
                unit: "km",
                value: psManager.electricCar),
            DashInfoDFWidget(
                label: "Water Saved",
                icon: FaIcon(
                  FontAwesomeIcons.handHoldingDroplet,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 14,
                ),
                unit: "L",
                value: psManager.waterSaved),
          ],
        ),
      ),
    );
  }
}
