import 'package:alan_voice/alan_voice.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/energy_efficiency_indicator.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/more_info_grid_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../EventsScreen/events_page_view.dart';
import '../test_screen.dart';
import '../weatherScreen/weatherControllers/weather_api.dart';
import '../weatherScreen/weather_page_view.dart';
import 'dashbaord_page_loading_view.dart';
import 'package:provider_test/screens/loginScreen/login_page_view.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/battery_view.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';

import 'dashboardAnimation/dashboard_animation_controller.dart';
import 'dashboardAnimation/dashboard_animation_provider.dart';
import 'dashboardComponents/dashboard_button_actions.dart';
import 'dashboardComponents/eco_score_card.dart';
import 'dashboardComponents/liveCharts/pv_live_chart.dart';
import 'dashboardComponents/more_info_bat_card.dart';
import 'dashboardComponents/more_info_load_card.dart';
import 'dashboardComponents/more_info_pv_card.dart';
import 'dashboardComponents/muli_daily_energy_card.dart';
import 'package:alan_voice/alan_voice.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // _DashboardWidgetState() {
  //   AlanVoice.addButton("1e7b405a0b96f10a7038e5097548796f2e956eca572e1d8b807a3e2338fdd0dc/stage");
  //   AlanVoice.onCommand.add((command) {
  //     debugPrint("got new command ${command.toString()}");
  //   });
  // }

  // _DashboardWidgetState({
  //   this.fabLocation = FloatingActionButtonLocation.endDocked,
  //   this.shape = const CircularNotchedRectangle(),
  //  this.alan = const
  // });

  bool greenEfficiencyVisibility = false;

  void _initWs(BuildContext context) {
    Provider.of<WsManager>(context, listen: false).initWs(context);
  }

  // final FloatingActionButtonLocation? fabLocation;
  // final NotchedShape shape;
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  bool isInit = false;

  bool _initPsManager(BuildContext context) {
    if (!isInit) {
      isInit = true;
      infoCard.add(dailyEnergyCard);
      Provider.of<PowerServiceManager>(context, listen: false).init(context);
      return true;
    }

    return false;
  }

  final bool _showFab = true;
  final bool _showNotch = true;
  final FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;

  String? selectedValue;
  List<String> items = [
    'Logout',
  ];

  PageController? pageViewController;

  List<Widget> infoCard = [];
  var pvCard = const PVcard();
  var loadCard = const LoadCard();
  var gridCard = const GridCard();
  var dailyEnergyCard = const DailyEnergyCard();
  var batCard = const BatCard();

  Future<void> _handleRefresh() async {
    // Provider.of<PowerServiceManager>(context, listen: false).init(context);
    // DashbaordAnimationController();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const DashboardWidget();
    }));
  }

  insertBatInfoCard() {
    final buttonAction = Provider.of<ButtonAction>(
      context,
      listen: false,
    );
    buttonAction.showMoreInfo(Colors.orange.withOpacity(0.5));
    if (infoCard[0] == batCard) {
      infoCard.removeAt(0);
      infoCard.add(dailyEnergyCard);
    } else {
      infoCard.removeAt(0);
      infoCard.add(batCard);
    }
    setState(() {});
  }

  insertGridInfoCard() {
    final buttonAction = Provider.of<ButtonAction>(
      context,
      listen: false,
    );
    buttonAction.showMoreInfo(Colors.red.withOpacity(0.5));
    if (infoCard[0] == gridCard) {
      infoCard.removeAt(0);
      infoCard.add(dailyEnergyCard);
    } else {
      infoCard.removeAt(0);
      infoCard.add(gridCard);
    }
    setState(() {});
  }

  insertLoadInfoCard() {
    final buttonAction = Provider.of<ButtonAction>(
      context,
      listen: false,
    );
    buttonAction.showMoreInfo(Colors.blue.withOpacity(0.5));
    if (infoCard[0] == loadCard) {
      infoCard.removeAt(0);
      infoCard.add(dailyEnergyCard);
    } else {
      infoCard.removeAt(0);
      infoCard.add(loadCard);
    }
    setState(() {});
  }

  insertPVInfoCard() {
    final buttonAction = Provider.of<ButtonAction>(
      context,
      listen: false,
    );
    buttonAction.showMoreInfo(Colors.green.withOpacity(0.5));
    if (infoCard[0] == pvCard) {
      infoCard.removeAt(0);
      infoCard.add(dailyEnergyCard);
    } else {
      infoCard.removeAt(0);
      infoCard.add(pvCard);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // button action provider
    final buttonAction = Provider.of<ButtonAction>(context);
    // animation providers
    final animProvider = Provider.of<DashboardAnimationProvider>(context);
    final pvToBatDotPosition = animProvider.pvToBatAnimationPositionVal;

    final psManager = Provider.of<PowerServiceManager>(context);
    String loadPower = (psManager.loadPower / 1000).toStringAsFixed(2);
    String pvPower = (psManager.pvPower / 1000).toStringAsFixed(2);
    String gridPower = (psManager.gridPower / 1000).toStringAsFixed(2);
    _initWs(context);
    _initPsManager(context);
    String batPower = psManager.batPower.toStringAsFixed(2);
    final batStorageTxt = psManager.batStorage.toStringAsFixed(1);
    final batStorageLevel = psManager.batStorage / 100;
    // final weatherData = Provider.of<WeatherApi>(
    //   context,
    //   listen: false,
    // );
    final energyEfficiencyPercentageTxt =
        psManager.energyEfficiencyPercentageTxt;
    final energyEfficiencyPercentage = psManager.energyEfficiency / 100;
    final energyLinePosition = psManager.energyLinePosition;
    // weatherData.queryWeather();
    // weatherData.queryForecast();
    // String gridPower = Provider.of<PowerServiceManager>(context).getGridPower.toStringAsFixed(2);
    // int random = Provider.of<WsManager>(context).getRandom;

    return Scaffold(
      // floatingActionButton: _showFab
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //           //   return  AlanTest();
      //           // }));
      //           // AddLoggerView.addLoggerDialog(context, setState);
      //         },
      //         backgroundColor:
      //             FlutterFlowTheme.of(context).primaryColor?.withOpacity(0.9),
      //         tooltip: 'Create',
      //         child: Icon(
      //           FontAwesomeIcons.chartPie,
      //           size: 22,
      //           color: FlutterFlowTheme.of(context).tertiaryColor,
      //         ),
      //       )
      //     : null,
      // floatingActionButtonLocation: _fabLocation,
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
                icon: const Icon(
                  Icons.speed_sharp,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
              // if (centerLocations.contains(fabLocation)) const Spacer(),
              const DashbaordAnimationController(),
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
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
          child: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            height: 50,
            animSpeedFactor: 2.4,
            color: FlutterFlowTheme.of(context).loadingBoxColor,
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            45, 0, 0, 0),
                                    child: Image.asset(
                                      'assets/images/Rectangle_12.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    45, 0, 0, 0),
                                child: Image.asset(
                                  'assets/images/Rectangle_22-9-7-7.png',
                                  width: 40,
                                  height: 30,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              LinearPercentIndicator(
                                  percent: batStorageLevel,
                                  //batteryLevel,
                                  width: 140,
                                  lineHeight: 15,
                                  animation: false,
                                  progressColor: Colors.green,
                                  //batteryLevelColor,
                                  backgroundColor: const Color(0x7DFFFFFF),
                                  center: Text(
                                    '$batStorageTxt%',
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
                          boxShadow: [
                            BoxShadow(
                              color: buttonAction.moreInfoColor,
                              offset: Offset(0.0, buttonAction.offsetRadius),
                              //(x,y)
                              blurRadius: buttonAction.blurRadius,
                            ),
                          ],
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 500,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 50),
                                child: PageView(
                                  controller: pageViewController ??=
                                      PageController(initialPage: 0),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Column(
                                      children: infoCard,
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 70, 0),
                                                  child: Text(
                                                    'Environmental Benefits',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 17,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
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
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                5, 0, 0, 0),
                                                        child: Text(
                                                          ' CO2 reduced',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 29,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1,
                                                                -0.050000000000000044),
                                                        child: Text(
                                                          psManager.c02Reduced
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 0, 4),
                                                        child: Text(
                                                          'kg',
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
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
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                7, 0, 0, 0),
                                                        child: Text(
                                                          'Electric car ',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 29,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1,
                                                                -0.050000000000000044),
                                                        child: Text(
                                                          psManager.electricCar
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 0, 4),
                                                        child: Text(
                                                          'km',
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
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
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                1, 0, 0, 0),
                                                        child: Text(
                                                          ' Water Saved',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 29,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1,
                                                                -0.050000000000000044),
                                                        child: Text(
                                                          psManager.waterSaved
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 0, 4),
                                                        child: Text(
                                                          'L',
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 70, 0),
                                                  child: Text(
                                                    'Financial Benefits',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 17,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
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
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                              .coins,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                5, 0, 0, 0),
                                                        child: Text(
                                                          'Daily',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 29,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1,
                                                                -0.050000000000000044),
                                                        child: Text(
                                                          psManager
                                                              .dailyFinancial
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
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
                                                .fromSTEB(0, 5, 0, 0),
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
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                              .coins,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                5, 0, 0, 0),
                                                        child: Text(
                                                          'Monthly',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 29,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1,
                                                                -0.050000000000000044),
                                                        child: Text(
                                                          psManager
                                                              .monthlyFinancial
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
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
                                                .fromSTEB(0, 5, 0, 0),
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
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                              .coins,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                5, 0, 0, 0),
                                                        child: Text(
                                                          'Total',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x00FFFFFF),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 29,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1,
                                                                -0.050000000000000044),
                                                        child: Text(
                                                          psManager
                                                              .totalFinancial
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1,
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
                                  ],
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0, 1),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: SmoothPageIndicator(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    count: 3,
                                    axisDirection: Axis.horizontal,
                                    onDotClicked: (i) {
                                      pageViewController?.animateToPage(
                                        i,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    effect: const ScaleEffect(
                                      dotHeight: 10,
                                      dotWidth: 10,
                                      // jumpScale: .7,
                                      // verticalOffset: 15,
                                      dotColor: Color(0xFF9E9E9E),
                                      activeDotColor: Color(0xFFFFBC00),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 125,
                          height: 75,
                        ),
                        SizedBox(
                          width: 100,
                          height: 75,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(30)),
                                    depth: 2,
                                    lightSource: LightSource.top,
                                    // shadowDarkColor: Colors.green,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: SizedBox(
                                    width: 49,
                                    height: 49,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Transform.translate(
                                            offset: const Offset(0, 11),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 1),
                                              child: RotatedBox(
                                                quarterTurns: -1,
                                                child: LinearPercentIndicator(
                                                    percent: psManager
                                                            .pvRatedPowerPercentageLevel /
                                                        100,
                                                    // percent:1,
                                                    //gridRatedPowerPercentageLevel / 100,
                                                    width: 70,
                                                    lineHeight: 49,
                                                    animation: false,
                                                    progressColor: Colors.green
                                                        .withOpacity(0.5),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    barRadius:
                                                        const Radius.circular(
                                                            3)),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: const Offset(-34, 1),
                                            child: FaIcon(
                                              FontAwesomeIcons.solarPanel,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  insertPVInfoCard();
                                  // buttonAction.showMoreInfo();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      pvPower,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 0, 0),
                                      child: Text(
                                        'kW',
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
                        const SizedBox(
                          width: 125,
                          height: 75,
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
                            InkWell(
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 25, 2, 0),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.concave,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(30)),
                                      depth: 2,
                                      lightSource: LightSource.top,
                                      // shadowDarkColor: Colors.red,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: SizedBox(
                                      width: 49,
                                      height: 49,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(0, 11),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 1),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: LinearPercentIndicator(
                                                      percent: psManager
                                                              .gridRatedPowerPercentageLevel /
                                                          100,
                                                      // percent:1,
                                                      //gridRatedPowerPercentageLevel / 100,
                                                      width: 70,
                                                      lineHeight: 49,
                                                      animation: false,
                                                      progressColor: Colors.red
                                                          .withOpacity(0.5),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      barRadius:
                                                          const Radius.circular(
                                                              3)),
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: const Offset(-37, 1),
                                              child: Icon(
                                                Icons.offline_bolt_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  // child: Image.asset(
                                  //   'assets/images/gridIcon.png',
                                  //   width: 54,
                                  //   height: 54,
                                  //   fit: BoxFit.fitHeight,
                                  // ),
                                  ),
                              onTap: () {
                                insertGridInfoCard();
                                // buttonAction.showMoreInfo();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    gridPower,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                    child: Text(
                                      'kW',
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
                            image:
                                FlutterFlowTheme.of(context).dashboard!.image,
                          ),
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Transform.translate(
                              offset: Offset(71.5, pvToBatDotPosition - 80),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 1),
                                child: Opacity(
                                  opacity: psManager.pvToBatDotActive,
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.green,
                                    size: 7,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(
                                  animProvider.gridAnimationPositionVal - 15,
                                  1),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 1),
                                child: Opacity(
                                  opacity: psManager.gridDotActive,
                                  // child: Image.asset(
                                  //    'assets/images/gridSpritOne.png',
                                  //    width: 10,
                                  //    height: 10,
                                  //    fit: BoxFit.fitHeight,
                                  //  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.red,
                                    size: 7,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(
                                  animProvider.loadAnimationPositionVal - -57.5,
                                  1),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 1),
                                child: Opacity(
                                  opacity: psManager.loadDotActive,
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.blue,
                                    size: 7,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(50,
                                  animProvider.batChargeAnimationPositionVal),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 1),
                                child: Opacity(
                                  opacity: psManager.batChargeDotActive,
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.orange,
                                    size: 7,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(
                                  43.5,
                                  animProvider
                                      .batDischargeAnimationPositionVal),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 1),
                                child: Opacity(
                                  opacity: psManager.batDischargeDotActive,
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.orange,
                                    size: 7,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            InkWell(
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 25, 0, 0),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.concave,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(30)),
                                      depth: 2,
                                      lightSource: LightSource.top,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      // shadowDarkColor: Colors.blue,
                                    ),
                                    child: SizedBox(
                                      width: 49,
                                      height: 49,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(0, 11),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 1),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: LinearPercentIndicator(
                                                      percent: psManager
                                                              .loadRatedPowerPercentageLevel /
                                                          100,
                                                      // percent:1,
                                                      //gridRatedPowerPercentageLevel / 100,
                                                      width: 70,
                                                      lineHeight: 49,
                                                      animation: false,
                                                      progressColor: Colors.blue
                                                          .withOpacity(0.5),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      barRadius:
                                                          const Radius.circular(
                                                              3)),
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: const Offset(-33, 1),
                                              child: FaIcon(
                                                FontAwesomeIcons.house,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // child: FaIcon(
                                        //   FontAwesomeIcons.house,
                                        //   color: FlutterFlowTheme.of(context)
                                        //       .tertiaryColor,
                                        //   size: 15,
                                        // ),
                                      ),
                                    ),
                                  )
                                  // child: Image.asset(
                                  //   'assets/images/loadIcon.png',
                                  //   width: 54,
                                  //   height: 54,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  ),
                              onTap: () {
                                insertLoadInfoCard();
                                // buttonAction.showMoreInfo();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    loadPower,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                    child: Text(
                                      'kW',
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
                            InkWell(
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
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
                                        child: Row(
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(0, 11),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 1),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: LinearPercentIndicator(
                                                      percent: psManager
                                                          .batRatedPowerPercentage,
                                                      // percent:1,
                                                      //gridRatedPowerPercentageLevel / 100,
                                                      width: 70,
                                                      lineHeight: 49,
                                                      animation: false,
                                                      progressColor: Colors
                                                          .orange
                                                          .withOpacity(0.5),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      barRadius:
                                                          const Radius.circular(
                                                              3)),
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                                offset: const Offset(-33, 1),
                                                child: Icon(
                                                  Icons
                                                      .battery_charging_full_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryColor,
                                                  size: 18,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                insertBatInfoCard();
                                // buttonAction.showMoreInfo();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    batPower,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                    child: Text(
                                      'kW',
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
                  Container(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white10,
                              offset: Offset(0.0, buttonAction.offsetRadius),
                              //(x,y)
                              blurRadius: buttonAction.blurRadius,
                            ),
                          ],
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 0),
                                        child: Text(
                                          "Eco Score",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                        energyEfficiencyPercentageTxt,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: psManager
                                                  .energyEfficiencyColor,
                                              fontSize: 14,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(1, 0, 0, 0),
                                        child: Text(
                                          '%',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              170, 0, 0, 0),
                                      child: Icon(
                                        Icons.info_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor
                                            ?.withOpacity(0.7),
                                        size: 20,
                                      ),
                                    ),
                                    onTap: () {
                                      if (greenEfficiencyVisibility == false) {
                                        greenEfficiencyVisibility = true;
                                      }else{
                                        greenEfficiencyVisibility = false;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.83,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.red,
                                      Colors.yellow,
                                      Colors.green
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: Offset(energyLinePosition, -15),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 1),
                                    child: Opacity(
                                        opacity: 1,
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            shape: NeumorphicShape.concave,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(30)),
                                            depth: 2,
                                            lightSource: LightSource.top,
                                            // shadowDarkColor: Colors.orange,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.cloudscale,
                                                color:
                                                psManager
                                                    .energyEfficiencyColor.withOpacity(0.7),
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Eco Score refers to how much of the electricity you use, comes from renewable sources like solar panels. ",
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
                              visible: greenEfficiencyVisibility,
                            ),
                            Visibility(
                              child: EcoCard(),
                              visible: greenEfficiencyVisibility,
                            ),
                          ],
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
    );
  }
}
