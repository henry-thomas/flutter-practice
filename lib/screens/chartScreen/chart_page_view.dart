import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:provider_test/screens/chartScreen/chart_controller.dart';

import '../EventsScreen/events_page_view.dart';
import '../dashboardScreen/dashboard_page_view.dart';
import '../loginScreen/login_page_view.dart';
import '../weatherScreen/weather_page_view.dart';
import 'chartComponents/date_picker_component.dart';

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

  DatePickerController _controller = DatePickerController();
  DateTime today = DateTime.now();

  DateTime _selectedValue = DateTime.now();

  setDatePicker() {
    Future.delayed(const Duration(milliseconds: 50), () {
    _controller.animateToSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chartController = Provider.of<ChartController>(context);
    final pvColor = chartController.pvPowerTypeIconSelectorColor;
    final gridColor = chartController.gridPowerTypeIconSelectorColor;
    final loadColor = chartController.loadPowerTypeIconSelectorColor;
    final batColor = chartController.batPowerTypeIconSelectorColor;
    final pvIconDepth = chartController.pvIconDepth;
    final gridIconDepth = chartController.gridIconDepth;
    final loadIconDepth = chartController.loadIconDepth;
    final batIconDepth = chartController.batIconDepth;
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
              IconButton(
                tooltip: 'Weather',
                icon: FaIcon(
                  FontAwesomeIcons.cloudSun,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 20,
                ),
                // icon: Icon(
                //   Icons.dashboard,
                //   color: FlutterFlowTheme.of(context).tertiaryColor,
                //   size: 22,
                // ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const WeatherPage();
                  }));
                },
              ),
              IconButton(
                tooltip: 'Events',
                icon: Icon(
                  Icons.event,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 20,
                ),
                // icon: Icon(
                //   Icons.dashboard,
                //   color: FlutterFlowTheme.of(context).tertiaryColor,
                //   size: 22,
                // ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const EventsPageView();
                  }));
                },
              ),
              IconButton(
                tooltip: 'Charts',
                icon: FaIcon(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const WeatherPage();
                  }));
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
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
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Today",
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
                    onTap: () {
                      // buttonAction.showMoreInfo();
                      setState(() {
                        if (datePickerVisibility == false) {
                          datePickerVisibility = true;
                        } else {
                          datePickerVisibility = false;
                        }
                        setDatePicker();
                      });
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 110,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white10,
                        ),
                      ],
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text("You Selected:"),
                        // Padding(
                        //   padding: EdgeInsets.all(5),
                        // ),
                        // Text(_selectedValue.toString()),
                        // Padding(
                        //   padding: EdgeInsets.all(10),
                        // ),
                        Container(
                          child: DatePicker(
                            today.subtract(Duration(days: 100)),

                            monthTextStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 10,
                                    ),
                            dayTextStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 10,
                                    ),
                            dateTextStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 19,
                                    ),

                            daysCount: 101,

                            width: 60,
                            height: 80,
                            controller: _controller,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: Color(0xFFFFBC00).withOpacity(0.7),
                            selectedTextColor: Colors.white,
                            // inactiveDates: [
                            //   DateTime.now().add(Duration(days: 3)),
                            //   DateTime.now().add(Duration(days: 4)),
                            //   DateTime.now().add(Duration(days: 7))
                            // ],
                            onDateChange: (date) {
                              // New date selected
                              setState(() {
                                _selectedValue = date;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                        depth: gridIconDepth,
                        lightSource: LightSource.top,
                        shadowDarkColor: gridColor,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Center(
                          child: Icon(
                            Icons.offline_bolt_outlined,
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    highlightColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    splashColor: FlutterFlowTheme.of(context).primaryBackground,
                    onTap: () {
                      // buttonAction.showMoreInfo();
                      chartController.gridSelected();
                    },
                  ),
                  InkWell(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                        depth: pvIconDepth,
                        lightSource: LightSource.top,
                        shadowDarkColor: pvColor,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.solarPanel,
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    highlightColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    splashColor: FlutterFlowTheme.of(context).primaryBackground,
                    onTap: () {
                      // buttonAction.showMoreInfo();
                      chartController.pvSelected();
                    },
                  ),
                  InkWell(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                        depth: loadIconDepth,
                        lightSource: LightSource.top,
                        shadowDarkColor: loadColor,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.house,
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    highlightColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    splashColor: FlutterFlowTheme.of(context).primaryBackground,
                    onTap: () {
                      // buttonAction.showMoreInfo();
                      chartController.loadSelected();
                    },
                  ),
                  InkWell(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                        depth: batIconDepth,
                        lightSource: LightSource.top,
                        shadowDarkColor: batColor,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Center(
                            child: Icon(
                          Icons.battery_charging_full_rounded,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          size: 18,
                        )),
                      ),
                    ),
                    highlightColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    splashColor: FlutterFlowTheme.of(context).primaryBackground,
                    onTap: () {
                      chartController.batSelected();
                      // buttonAction.showMoreInfo();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
