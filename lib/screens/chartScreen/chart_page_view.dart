import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:provider_test/providers/device_manager.dart';
import 'package:provider_test/providers/power_type_chart_manager.dart';
import 'package:provider_test/screens/chartScreen/power_type_chart.dart';

import '../../flutterFlow/flutter_flow_util.dart';
import '../loginScreen/login_page_view.dart';
import 'chartComponents/chart_actions.dart';
import 'chartComponents/chart_selector_card.dart';
import 'live_chart_card_widget.dart';

class ChartsPageView extends StatefulWidget {
  const ChartsPageView({Key? key}) : super(key: key);

  @override
  State<ChartsPageView> createState() => _ChartsPageViewState();
}

class _ChartsPageViewState extends State<ChartsPageView> {
  String? selectedValue;
  List<String> items = [
    'Logout',
  ];

  bool datePickerVisibility = false;

  @override
  Widget build(BuildContext context) {
    var ptcdm = Provider.of<PowerTypeChartDataManager>(context);
    var eStorageList = ptcdm.getEStorageList;
    var powerTypeMap = ptcdm.getPowerTypeMap;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme: IconThemeData(
            color: FlutterFlowTheme.of(context).primaryBackground),
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
                      child: Row(
                        children: [
                          Text(
                            Provider.of<PowerTypeChartDataManager>(context,
                                    listen: false)
                                .selectedDateStr,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
                    highlightColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    splashColor: FlutterFlowTheme.of(context).primaryBackground,
                    onTap: () async {
                      Provider.of<PowerTypeChartDataManager>(context,
                              listen: false)
                          .onDatePickerOpen(context);
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
                        'Showing Data For:',
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
                          DateFormat("MMMM d")
                              .format(ptcdm.selectedDate!)
                              .toString(),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: LiveChartCard(),
            ),
          ],
        ),
      )),
    );
  }
}
