import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/websocket/ps_manager.dart';
import 'liveCharts/pv_live_chart.dart';

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
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [LivePvChart()],
      ),
    );
  }
}
