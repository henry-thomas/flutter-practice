import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dashboardComponents/add_logger_view.dart';
import 'dashbaord_page_loading_view.dart';
import 'package:provider_test/screens/loginScreen/login_page_view.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/battery_view.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _DashboardWidgetState({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  static String loggerSerial = ApiController.SELECTED_LOGGER;
  static String devModel = "12";
  static String url = 'ws://192.168.100.18:8084/SolarMDApi/mobile?token=' +
      ApiController.jwt +
      '&loggerSerial=' +
      loggerSerial +
      '&deviceModel=' +
      devModel;



  static final channel = WebSocketChannel.connect(Uri.parse(url));

  void _processMessage(BuildContext context, Map<String, dynamic> msg,
      WebSocketChannel channel) {
    Provider.of<WsManager>(context, listen: true)
        .processMessage(msg, channel, context);
  }

  final FloatingActionButtonLocation? fabLocation;
  final NotchedShape shape;
  static final List<FloatingActionButtonLocation> centerLocations =
  <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  // final String _currentPage = 'dashboard';
  final bool _showFab = true;
  final bool _showNotch = true;
  final FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;


  String? selectedValue;
  List<String> items = [
    'Logout',
  ];

  PageController? pageViewController;

  @override
  Widget build(BuildContext context) {
    double batPower = context.watch<PowerServiceManager>().getBatPower;
    // String gridPower = Provider.of<PowerServiceManager>(context).getGridPower.toStringAsFixed(2);
    // int random = Provider.of<WsManager>(context).getRandom;

    return Scaffold(
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                channel.sink.close();
                // AddLoggerView.addLoggerDialog(context, setState);
              },
              backgroundColor:
                  FlutterFlowTheme.of(context).primaryColor?.withOpacity(0.9),
              tooltip: 'Create',
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: _fabLocation,
      bottomNavigationBar: BottomAppBar(
        shape: _showNotch ? const CircularNotchedRectangle() : null,
        color: FlutterFlowTheme.of(context).primaryColor?.withOpacity(0.7),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Dashboard',
                icon: const Icon(
                  Icons.speed_sharp,
                  size: 24,
                ),
                onPressed: () {},
              ),
              if (centerLocations.contains(fabLocation)) const Spacer(),
              IconButton(
                tooltip: 'Charts',
                icon: Icon(
                  FontAwesomeIcons.chartPie,
                  size: 18,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DashboardLoadingWidget(
                      // selectedSerial: loggerSerial,
                    );
                  }));
                },
              ),
              IconButton(
                tooltip: 'Card Dashboard',
                icon: Icon(
                  Icons.dashboard,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  size: 22,
                ),
                onPressed: () {
                  // changeDashboard();
                  // setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme:
        IconThemeData(color: FlutterFlowTheme.of(context).tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          "loggerDescription",
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
      drawer: Drawer(
        elevation: 16,
        child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: InkWell(
                          child: Container(
                            width: 30,
                            height: 30,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/userIcon.png',
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Text(
                        "SolarMdData().usernameGlobal",
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),

                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.max,
                  // children: initLoggerList(context),
                ),
              ],
            )),
      ),

      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LinearProgressIndicator(
                  value: 0.2,//linearProgress.value,
                  // A value of 0.0 means no progress and 1.0 means that progress is complete.
                  valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context)
                          .primaryColor!
                          .withOpacity( 0.2)), //linerAnimOpacity
                  backgroundColor: Colors.grey.withOpacity(0.0),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: FlutterFlowTheme.of(context).backDrop!.image,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      45, 0, 0, 0),
                                  child: Image.asset(
                                    'assets/images/Rectangle_12.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 8, 0, 0),
                                  child: Text(
                                    "loggerDescription",
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 8, 0, 0),
                                  child: Text(
                                    "loggerSerial",
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
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(45, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/Rectangle_22-9-7-7.png',
                                width: 40,
                                height: 30,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            LinearPercentIndicator(
                                percent: 0.0,//batteryLevel,
                                width: 140,
                                lineHeight: 15,
                                animation: false,
                                progressColor: Colors.green, //batteryLevelColor,
                                backgroundColor: const Color(0x7DFFFFFF),
                                center: Text(
                                  'batteryStorage%',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 10,
                                  ),
                                ),
                                barRadius: const Radius.circular(10)),
                            const Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            ),
                            StreamBuilder(
                              stream: channel.stream,
                              builder: (context, snapshot) {
                                var data = jsonDecode(snapshot.data.toString());
                                try {
                                  _processMessage(context, data, channel);

                                } catch (e) {
                                  // ignore: avoid_print
                                  print(e);
                                }

                                return const Text(
                                  '',
                                );
                              },
                            ),
                            // StreamBuilder(
                            //   stream: _channel.stream,
                            //   builder: (context, snapshot) {
                            //     var data = jsonDecode(snapshot.data.toString());
                            //
                            //     try {
                            //       if (data['msgType'] == "connectionInit") {
                            //         Message msg = Message();
                            //         msg.msgType = "conConfig";
                            //         msg.devModel = 12;
                            //         _channel.sink.add(jsonEncode(msg.toJson()));
                            //       } else {
                            //         processMessage(data);
                            //       }
                            //     } catch (e) {
                            //       print(e);
                            //     }
                            //
                            //     return Text(
                            //       '',
                            //       style: FlutterFlowTheme.of(context).bodyText1,
                            //     );
                            //   },
                            // ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              // children: [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 210,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                              child: PageView(
                                controller: pageViewController ??=
                                    PageController(initialPage: 0),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 10, 0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .solarPanel,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiaryColor,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Daily PV',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .primaryBackground,
                                                    ),
                                                    alignment: const AlignmentDirectional(
                                                        -0.050000000000000044,
                                                        -0.050000000000000044),
                                                    child: Text(
                                                      "$batPower",
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'kWh',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 10, 0),
                                                    child: Icon(
                                                      Icons
                                                          .offline_bolt_outlined,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Daily Grid',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .primaryBackground,
                                                    ),
                                                    alignment: const AlignmentDirectional(
                                                        -0.050000000000000044,
                                                        -0.050000000000000044),
                                                    child: Text(
                                                      "dailyGrid",
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'kWh',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 10, 0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.house,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiaryColor,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Daily Load',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .primaryBackground,
                                                    ),
                                                    alignment: const AlignmentDirectional(
                                                        -0.050000000000000044,
                                                        -0.050000000000000044),
                                                    child: Text(
                                                      "dailyLoad",
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'kWh',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 0, 0),
                                                    child: Icon(
                                                      Icons
                                                          .battery_charging_full_outlined,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Time until ',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .primaryBackground,
                                                    ),
                                                    alignment: const AlignmentDirectional(
                                                        -0.050000000000000044,
                                                        -0.050000000000000044),
                                                    child: Text(
                                                      "00.00",
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Poppins',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: const Color(0x00EEEEEE),
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: Image.asset(
                                          'assets/images/rect1405.png',
                                        ).image,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 70, 0),
                                                child: Text(
                                                  'Enviromental Benefits',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .cloudMeatball,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .tertiaryColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5, 0, 0, 0),
                                                      child: Text(
                                                        ' CO2 reduced',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 29,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                        Color(0x00FFFFFF),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          -1,
                                                          -0.050000000000000044),
                                                      child: Text(
                                                        "c02Reduced",
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 0, 0, 4),
                                                      child: Text(
                                                        'kg',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: const Color(
                                                              0xFF3999D2),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Icon(
                                                        Icons.electric_car,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .tertiaryColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          7, 0, 0, 0),
                                                      child: Text(
                                                        'Electric car ',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 29,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                        Color(0x00FFFFFF),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          -1,
                                                          -0.050000000000000044),
                                                      child: Text(
                                                        "electricCar",
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 0, 0, 4),
                                                      child: Text(
                                                        'km',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: const Color(
                                                              0xFF3999D2),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .handHoldingDroplet,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .tertiaryColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          1, 0, 0, 0),
                                                      child: Text(
                                                        ' Water Saved',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 29,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                        Color(0x00FFFFFF),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          -1,
                                                          -0.050000000000000044),
                                                      child: Text(
                                                        "waterSaved",
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 0, 0, 4),
                                                      child: Text(
                                                        'L',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: const Color(
                                                              0xFF3999D2),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: const Color(0x00EEEEEE),
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: Image.asset(
                                          'assets/images/moneyBackground.png',
                                        ).image,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 70, 0),
                                                child: Text(
                                                  'Financial Benefits',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.coins,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .tertiaryColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5, 0, 0, 0),
                                                      child: Text(
                                                        'Daily',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 1, 5, 4),
                                                      child: Text(
                                                        'R',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: const Color(
                                                              0xFF775B0E),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 29,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                        Color(0x00FFFFFF),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          -1,
                                                          -0.050000000000000044),
                                                      child: Text(
                                                        "dailyFinancial",
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.coins,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .tertiaryColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5, 0, 0, 0),
                                                      child: Text(
                                                        'Monthly',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 1, 5, 4),
                                                      child: Text(
                                                        'R',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: const Color(
                                                              0xFF775B0E),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 29,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                        Color(0x00FFFFFF),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          -1,
                                                          -0.050000000000000044),
                                                      child: Text(
                                                        "monthlyFinancial",
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.coins,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .tertiaryColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          5, 0, 0, 0),
                                                      child: Text(
                                                        'Total',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 1, 5, 4),
                                                      child: Text(
                                                        'R',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: const Color(
                                                              0xFF775B0E),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 29,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                        Color(0x00FFFFFF),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          -1,
                                                          -0.050000000000000044),
                                                      child: Text(
                                                        "totalFinancial",
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: const <Widget>[],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                10,
                                                                0),
                                                            child: Icon(
                                                              Icons
                                                                  .battery_charging_full,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .tertiaryColor,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          Text(
                                                            "batStateTxt",
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyText1,
                                                          ),
                                                          Text(
                                                            '(batExport) kW',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyText1
                                                                .override(
                                                              fontFamily:
                                                              'Poppins',
                                                              color: const Color(
                                                                  0xFF3999D2),
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 130,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  10,
                                                                  0),
                                                              child: Icon(
                                                                Icons.bolt,
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .tertiaryColor,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Voltage',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 60,
                                                              height: 29,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                              ),
                                                              alignment: const AlignmentDirectional(
                                                                  -0.050000000000000044,
                                                                  -0.050000000000000044),
                                                              child: Text(
                                                                "batVoltage",
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                            Text(
                                                              'V',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondaryText,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 130,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  10,
                                                                  0),
                                                              child: Icon(
                                                                Icons.bolt,
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .tertiaryColor,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Current',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 60,
                                                              height: 29,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                              ),
                                                              alignment: const AlignmentDirectional(
                                                                  -0.050000000000000044,
                                                                  -0.050000000000000044),
                                                              child: Text(
                                                                "batCurrent",
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                            Text(
                                                              'A',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondaryText,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 130,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  10,
                                                                  0),
                                                              child: Icon(
                                                                Icons.bolt,
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .tertiaryColor,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Power',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 60,
                                                              height: 29,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                              ),
                                                              alignment: const AlignmentDirectional(
                                                                  -0.050000000000000044,
                                                                  -0.050000000000000044),
                                                              child: Text(
                                                                "batPowerW",
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                            Text(
                                                              'W',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondaryText,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 15, top: 16),
                                        child: Container(
                                          width: 50,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFAACBCE)
                                                .withOpacity(0.4),
                                            borderRadius:
                                            const BorderRadius.only(
                                                topLeft:
                                                Radius.circular(80.0),
                                                bottomLeft:
                                                Radius.circular(80.0),
                                                bottomRight:
                                                Radius.circular(80.0),
                                                topRight:
                                                Radius.circular(80.0)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  offset: const Offset(2, 2),
                                                  blurRadius: 4),
                                            ],
                                          ),
                                          child: const BatteryView(
                                            percentageValue: 50 //batStorage,
                                            // percentageValue: 60,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 1),
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: SmoothPageIndicator(
                                  controller: pageViewController ??=
                                      PageController(initialPage: 0),
                                  count: 4,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) {
                                    pageViewController?.animateToPage(
                                      i,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  effect: const ScaleEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    // jumpScale: .7,
                                    // verticalOffset: 15,
                                    dotColor: Color(0xFF9E9E9E),
                                    activeDotColor:  Color(0xFFFFBC00),
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 75,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 75,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/pvIcon.png',
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '00.00',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'kW☀️',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                        fontFamily: 'Poppins',
                                        color:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 75,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Image.asset(
                              'assets/images/gridIcon.png',
                              width: 54,
                              height: 54,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "00.00",
                                  style:
                                  FlutterFlowTheme.of(context).bodyText1,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'kW🔌',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      // child: const SpinKitCircle(
                      //   color: Color(0xFFF2CC0D),
                      //   size: 100.0,
                      // ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,

                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:FlutterFlowTheme.of(context).dashboard!.image,
                        ),
                      ),
                      alignment: const AlignmentDirectional(0, 0),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Image.asset(
                              'assets/images/loadIcon.png',
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '00.00',
                                  style:
                                  FlutterFlowTheme.of(context).bodyText1,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'kW💡',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 70,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            'assets/images/batteryIcon.png',
                            width: 54,
                            height: 49,
                            fit: BoxFit.fitHeight,
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '00.00',
                                  style:
                                  FlutterFlowTheme.of(context).bodyText1,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'kW🔋',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
