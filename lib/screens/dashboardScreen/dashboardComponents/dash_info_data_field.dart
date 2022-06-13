import 'package:flutter/material.dart';

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
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 112,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.transparent,
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
            width: 120,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 29,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  alignment: const AlignmentDirectional(-0.05, -0.05),
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
