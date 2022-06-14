// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../flutterFlow/flutter_flow_theme.dart';
// import '../../../flutterFlow/flutter_flow_util.dart';
// import '../../../providers/power_type_chart_manager.dart';
// import '../../../providers/websocket/ps_manager.dart';
// import '../../dashboardScreen/dashboardComponents/liveCharts/pv_live_chart.dart';
// import '../power_type_chart.dart';
// import 'chart_actions.dart';
//
// class LiveChartMenuItem extends StatefulWidget {
//   const LiveChartMenuItem({Key? key}) : super(key: key);
//
//   @override
//   State<LiveChartMenuItem> createState() => _LiveChartMenuItemState();
// }
//
// class _LiveChartMenuItemState extends State<LiveChartMenuItem> {
//   bool liveChartVisibility = false;
//   bool liveChartSnapShot = true;
//
//   DateTime now = DateTime.now();
//   // var lastUpdated = DateFormat("MMMM d").format(now);
//
//   @override
//   Widget build(BuildContext context) {
//     var ptcdm = Provider.of<PowerTypeChartDataManager>(context);
//     var eStorageList = ptcdm.getEStorageList;
//     var powerTypeMap = ptcdm.getPowerTypeMap;
//     var chartsActions = Provider.of<ChartActions>(context);
//
//     final psManager = Provider.of<PowerServiceManager>(context);
//     String loadPower = (psManager.loadPower / 1000).toStringAsFixed(2);
//     String pvPower = (psManager.pvPower / 1000).toStringAsFixed(2);
//     String gridPower = (psManager.gridPower / 1000).toStringAsFixed(2);
//
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.95,
//       decoration: BoxDecoration(
//         color:
//             FlutterFlowTheme.of(context).secondaryBackground?.withOpacity(0.4),
//         borderRadius: BorderRadius.circular(10),
//         shape: BoxShape.rectangle,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: FlutterFlowTheme.of(context).secondaryBackground,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(0),
//                 bottomRight: Radius.circular(0),
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   'Live Chart',
//                   style: FlutterFlowTheme.of(context).bodyText1.override(
//                         fontFamily: 'Poppins',
//                         color: FlutterFlowTheme.of(context).secondaryText,
//                         fontSize: 11,
//                       ),
//                 ),
//                 InkWell(
//                   child: Icon(
//                     Icons.bar_chart_rounded,
//                     color: FlutterFlowTheme.of(context).tertiaryColor,
//                     size: 26,
//                   ),
//                   onTap: () {
//                     // chartsActions.liveChartMenuOpen();
//                     setState(() {
//                       if (liveChartVisibility == false) {
//                         liveChartVisibility = true;
//                         liveChartSnapShot = false;
//                       } else {
//                         liveChartVisibility = false;
//                         liveChartSnapShot = true;
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: liveChartSnapShot,
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   height: 70,
//                   width: 100,
//                   child: LivePvChart(),
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           // mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
//                               child: Text(
//                                 "Grid Power",
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       fontSize: 11,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           // mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               gridPower,
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.red.withOpacity(0.5),
//                                     fontSize: 14,
//                                   ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
//                               child: Text(
//                                 'kWh',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           // mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
//                               child: Text(
//                                 "Load Power",
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       fontSize: 11,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           // mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               loadPower,
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.blue.withOpacity(0.5),
//                                     fontSize: 14,
//                                   ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
//                               child: Text(
//                                 'kWh',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           // mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
//                               child: Text(
//                                 "Pv Power",
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       fontSize: 11,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           // mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               pvPower,
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.green.withOpacity(0.5),
//                                     fontSize: 14,
//                                   ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
//                               child: Text(
//                                 'kWh',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: liveChartVisibility,
//             child: LivePvChart(),
//           )
//         ],
//       ),
//     );
//   }
// }
