import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../flutterFlow/flutter_flow_theme.dart';
import '../dashboardScreen/dashboard_page_view.dart';
import '../loginScreen/login_page_view.dart';
import '../weatherScreen/weather_page_view.dart';
import 'events_row_component.dart';

class EventsPageView extends StatefulWidget {
  const EventsPageView({Key? key}) : super(key: key);

  @override
  State<EventsPageView> createState() => _EventsPageViewState();
}

class _EventsPageViewState extends State<EventsPageView> {
  final bool _showNotch = true;
  String? selectedValue;
  List<String> items = [
    'Logout',
  ];

  String? selectedLevelValue;
  List<String> levelItems = [
    "Info","Error", "Warning", "Debug","Trace", "CONFIG_ADV", "CONFIG"
  ];
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> eventsList = [
      EventsRow().getEventRow(context, "info"),
      EventsRow().getEventRow(context, "error"),
      EventsRow().getEventRow(context, "warning"),
      EventsRow().getEventRow(context, "debug"),
      EventsRow().getEventRow(context, "trace"),
    ];
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
                  color: Colors.white,
                  size: 20,
                ),
                // icon: Icon(
                //   Icons.dashboard,
                //   color: FlutterFlowTheme.of(context).tertiaryColor,
                //   size: 22,
                // ),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Charts',
                icon: FaIcon(
                  FontAwesomeIcons.chartPie,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
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
          "Events",
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
             Row(
               mainAxisSize: MainAxisSize.max,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children:  [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: FlutterFlowTheme
                                .of(context)
                                .tertiaryColor,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Select Level',
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
                      items: levelItems
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context)
                                .secondaryText,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedLevelValue,
                      onChanged: (value) {
                        setState(() {
                          selectedLevelValue = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor:FlutterFlowTheme
                          .of(context)
                          .tertiaryColor,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: 130,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),

                        color: FlutterFlowTheme.of(
                            context)
                            .primaryBackground,
                      ),
                      buttonElevation: 1,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: FlutterFlowTheme.of(
                            context)
                            .primaryBackground,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(10),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
            ),
                 ),
               ],
             ),
            SingleChildScrollView(
                child: Column(
              children: eventsList,
            )),
          ],
        ),
      ),
    );
  }
}
