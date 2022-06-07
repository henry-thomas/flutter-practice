import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class DashInfoDFWidget extends StatelessWidget {
  final double value;
  final String unit;
  final String label;
  final Widget icon;

  const DashInfoDFWidget(
      {Key? key,
      required this.value,
      required this.unit,
      required this.label,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 140,
            height: 30,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: icon,
                ),
                Text(
                  label,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            height: 30,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 80,
                  height: 29,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  alignment: const AlignmentDirectional(
                      -0.050000000000000044, -0.050000000000000044),
                  child: Text(
                    value.toStringAsFixed(2),
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ),
                Text(
                  unit,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 11,
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
