import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider_test/entities/dev_power_summary.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class DashboardAnimImage extends StatelessWidget {
  final Widget icon;
  double? powerW;
  double? ratedPowerW;
  Function? onTap;
  Color? fillColor;
  double? offset;

  DashboardAnimImage(
      {Key? key,
      required this.icon,
      this.powerW,
      this.ratedPowerW,
      this.onTap,
        this.offset,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getPowerPercentage() {
      double perc = 0;

      powerW ??= 0;
      ratedPowerW ??= 0;

      if (ratedPowerW! > 0) {
        perc = (powerW! / ratedPowerW!);
      }

      if (perc > 1) {
        perc = 1;
      }

      return perc;
    }

    fillColor ??= Colors.green.withOpacity(0.5);

    return SizedBox(
      width: 80,
      height: 85,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                intensity: 0,
                surfaceIntensity: 5,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
                // depth: 2,
                // lightSource: LightSource.top,
                color: FlutterFlowTheme.of(context).primaryBackground,
                border: NeumorphicBorder(
                    width: 2, color: fillColor!.withOpacity(0.5)),
              ),
              child: SizedBox(
                width: 60,
                height: 60,
                child: Center(
                  child: Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 10),
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: LinearPercentIndicator(
                              percent: getPowerPercentage(),
                              // percent:1,
                              //gridRatedPowerPercentageLevel / 100,
                              width: 80,
                              lineHeight: 60,
                              animation: false,
                              progressColor: fillColor!.withOpacity(0.5),
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              barRadius: const Radius.circular(0)),
                        ),
                      ),
                      Transform.translate(
                        offset:  Offset(this.offset!, 0),
                        child: icon,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              onTap!();
            },
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (powerW! / 1000).toStringAsFixed(2),
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: Text(
                    'kW',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
