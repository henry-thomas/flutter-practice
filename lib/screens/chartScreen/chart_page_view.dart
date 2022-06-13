import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:provider_test/providers/power_type_chart_manager.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/screens/chartScreen/power_type_chart.dart';

import '../../flutterFlow/flutter_flow_util.dart';
import '../EventsScreen/events_page_view.dart';
import '../dashboardScreen/dashboardComponents/liveCharts/pv_live_chart.dart';
import '../dashboardScreen/dashboard_page_view.dart';
import '../loginScreen/login_page_view.dart';
import '../weatherScreen/weather_page_view.dart';
import 'chartComponents/chart_actions.dart';
import 'chartComponents/chart_selector_card.dart';
import 'chartComponents/live_chart_selector_card.dart';

class ChartsPageView extends StatefulWidget {
  const ChartsPageView({Key? key}) : super(key: key);

  @override
  State<ChartsPageView> createState() => _ChartsPageViewState();
}

class _ChartsPageViewState extends State<ChartsPageView> {
  final bool _showNotch = true;
  String? selectedValue;
  List<String> items = [
    'Logout',
  ];

  bool datePickerVisibility = false;

  DateTime today = DateTime.now();

  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var ptcdm = Provider.of<PowerTypeChartDataManager>(context);
    var eStorageList = ptcdm.getEStorageList;
    var powerTypeMap = ptcdm.getPowerTypeMap;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: _showNotch ? const CircularNotchedRectangle() : null,
        color: FlutterFlowTheme.of(context).primaryColor?.withOpacity(0.7),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                tooltip: 'Dashboard',
                splashColor: Colors.white,
                icon: Icon(
                  Icons.speed_sharp,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DashboardWidget();
                  }));
                },
              ),
              // if (centerLocations.contains(fabLocation)) const Spacer(),
              // IconButton(
              //   tooltip: 'Weather',
              //   icon: FaIcon(
              //     FontAwesomeIcons.cloudSun,
              //     color: FlutterFlowTheme.of(context).tertiaryColor,
              //     size: 20,
              //   ),
              //   // icon: Icon(
              //   //   Icons.dashboard,
              //   //   color: FlutterFlowTheme.of(context).tertiaryColor,
              //   //   size: 22,
              //   // ),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return const WeatherPage();
              //     }));
              //   },
              // ),
              // IconButton(
              //   tooltip: 'Events',
              //   icon: Icon(
              //     Icons.event,
              //     color: FlutterFlowTheme.of(context).tertiaryColor,
              //     size: 20,
              //   ),
              //   // icon: Icon(
              //   //   Icons.dashboard,
              //   //   color: FlutterFlowTheme.of(context).tertiaryColor,
              //   //   size: 22,
              //   // ),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return const EventsPageView();
              //     }));
              //   },
              // ),
              IconButton(
                tooltip: 'Power Chart',
                icon: const FaIcon(
                  FontAwesomeIcons.chartPie,
                  color: Colors.white,
                  size: 18,
                ),
                // icon: Icon(
                //   Icons.dashboard,
                //   color: FlutterFlowTheme.of(context).tertiaryColor,
                //   size: 22,
                // ),
                onPressed: () {
                  // Provider.of<PowerTypeChartDataManager>(context, listen: false)
                  //     .getPowerTypesFromDateRange(
                  //         context,
                  //         DateTime.parse('20220606'),
                  //         DateTime.parse('20220606'));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const WeatherPage();
                  // }));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme:
            IconThemeData(color: FlutterFlowTheme.of(context).tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          "Charts",
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPageWidget(),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/images/g865.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.fitWidth,
                ),
                buttonHeight: 20,
                buttonWidth: 100,
                buttonDecoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                buttonElevation: 0,
                itemHeight: 20,
                dropdownMaxHeight: 100,
                dropdownWidth: 100,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                dropdownElevation: 0,
                offset: const Offset(10, 0),
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 1,
                    color: FlutterFlowTheme.of(context).secondaryColor,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              Provider.of<PowerTypeChartDataManager>(context,
                                      listen: false)
                                  .selectedDateStr,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
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
                    ),
                    highlightColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    splashColor: FlutterFlowTheme.of(context).primaryBackground,
                    onTap: () async {
                      DateTime? selectedDate =
                          await Provider.of<PowerTypeChartDataManager>(context,
                                  listen: false)
                              .onDatePickerOpen(context);

                      Provider.of<PowerTypeChartDataManager>(context,
                              listen: false)
                          .getPowerTypesFromDateRange(context);
                    },
                  ),
                  Container(
                    width: 120,
                    height: 1,
                    color: FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: datePickerVisibility,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 10),
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            // PowerTypeChart.buildChart(powerTypeMap, eStorageList),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: ChartMenuItem(
                chart: PowerTypeChart.buildChart(powerTypeMap, eStorageList),
                heading: "Power Chart",
                onTabCb: Provider.of<ChartActions>(context).onMenuOpen,
                infoWgtList: [
                  Row(
                    children: [
                      Text(
                        'Last Updated:',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11,
                            ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Text(
                          DateFormat("MMMM d  hh:mm:ss")
                              .format(DateTime.now())
                              .toString(),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: ChartMenuItem(
                chart: LivePvChart(),
                heading: "Live Chart",
                onTabCb: Provider.of<ChartActions>(context).liveChartMenuOpen,
                infoWgtList: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: Text(
                                  "Grid Power",
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                Provider.of<PowerServiceManager>(context)
                                    .gridPower
                                    .toStringAsFixed(2),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.red.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                child: Text(
                                  'kW',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: Text(
                                  "Load Power",
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                Provider.of<PowerServiceManager>(context)
                                    .loadPower
                                    .toStringAsFixed(2),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                child: Text(
                                  'kW',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: Text(
                                  "Pv Power",
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                Provider.of<PowerServiceManager>(context)
                                    .pvPower
                                    .toStringAsFixed(2),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.green.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                child: Text(
                                  'kW',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
