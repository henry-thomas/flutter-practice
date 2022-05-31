import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../../../providers/websocket/ps_manager.dart';


class EcoCard extends StatefulWidget {
  const EcoCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EcoCardState();
}

class EcoCardState extends State {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections()),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final psManager = Provider.of<PowerServiceManager>(context);

    final energyEfficiencyPercentageTxt = psManager.energyEfficiencyPercentageTxt;
    final energyEfficiencyPercentage = psManager.energyEfeciancy;
    final gridEfficiency = 100-energyEfficiencyPercentage;
    final gridEfficiencyPercentageTxt = gridEfficiency.toStringAsFixed(1);
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color:Colors.red,
            value: gridEfficiency,
            title: '$gridEfficiencyPercentageTxt%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(30)),
                depth: 2,
                lightSource: LightSource.top,
                // shadowDarkColor: Colors.orange,
                color: FlutterFlowTheme.of(context)
                    .primaryBackground,
              ),
              child: SizedBox(
                width: 39,
                height: 39,
                child: Center(
                  child:Icon(
                    Icons.offline_bolt_outlined,
                    color:
                    FlutterFlowTheme.of(context)
                        .tertiaryColor,
                    size: 25,
                  ),
                ),
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: energyEfficiencyPercentage,
            title: '$energyEfficiencyPercentageTxt%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(30)),
                depth: 2,
                lightSource: LightSource.top,
                // shadowDarkColor: Colors.orange,
                color: FlutterFlowTheme.of(context)
                    .primaryBackground,
              ),
              child: SizedBox(
                width: 39,
                height: 39,
                child: Center(
                  child:FaIcon(
                    FontAwesomeIcons.leaf,
                    color:
                    FlutterFlowTheme.of(context)
                        .tertiaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
      this.svgAsset, {
        Key? key,
        required this.size,
        required this.borderColor,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(30)),
              depth: 2,
              lightSource: LightSource.top,
              // shadowDarkColor: Colors.orange,
              color: FlutterFlowTheme.of(context)
                  .primaryBackground,
            ),
            child: SizedBox(
              width: 49,
              height: 49,
              child: Center(
                child:FaIcon(
                  FontAwesomeIcons.house,
                  color:
                  FlutterFlowTheme.of(context)
                      .tertiaryColor,
                  size: 15,
                ),
              ),
            ),
          )
      ),
    );
  }
}