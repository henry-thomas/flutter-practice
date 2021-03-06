import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider_test/entities/logger.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_test/providers/device_manager.dart';
import 'package:provider_test/providers/websocket/es_manager.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/dash_anim_img.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider_test/screens/loginScreen/login_page_view.dart';
import 'package:provider/provider.dart';
import '../profileScreen/profileSettings/electricity_settings.dart';
import 'dashboardAnimation/dashboard_animation_controller.dart';
import 'dashboardAnimation/dashboard_animation_provider.dart';
import 'dashboardComponents/dash_info_data_field.dart';
import 'dashboardComponents/dashboard_button_actions.dart';
import 'dashboardComponents/logger_list_component.dart';
import 'dashboardComponents/more_info_bat_card.dart';
import 'dashboardComponents/power_type_card.dart';
import 'dashboardComponents/muli_daily_energy_card.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool greenEfficiencyVisibility = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infoCard.add(dailyEnergyCard);
  }

  // bool isWsInit = false;
  // void _initWs(BuildContext context) {
  //   if (!isWsInit) {
  //     isWsInit = true;
  //     Provider.of<WsManager>(context, listen: false).initWs(context);
  //   }
  // }

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  // bool isPsInit = false;
  // bool isEsInit = false;

  // bool _initPsManager(BuildContext context) {
  //   if (!isPsInit) {
  //     isPsInit = true;
  //     Provider.of<PowerServiceManager>(context, listen: false).init(context);
  //     return true;
  //   }

  //   return false;
  // }

  // bool _initEsManager(BuildContext context) {
  //   if (!isEsInit) {
  //     isEsInit = true;
  //     Provider.of<EnergyStorageServiceManager>(context, listen: false)
  //         .init(context);
  //     return true;
  //   }

  //   return false;
  // }

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
  var pvCard = const PowerInfoCard(powerType: "PV");
  var loadCard = const PowerInfoCard(powerType: "Load");
  var gridCard = const PowerInfoCard(powerType: "Grid");
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

  List<Widget> loggerListItem = [];
  bool init = false;
  void initLoggerList(BuildContext context) async {
    if (!init) {
      init = true;
      // await __initDevManager(context);

      // loggerListItem.clear();
      // final weatherData = Provider.of<WeatherApi>(
      //   context,
      //   listen: false,
      // );
      // weatherData.queryWeather();
      final devManager = Provider.of<DeviceManager>(context, listen: false);

      List<Logger> getLoggerList = devManager.getLoggerList;

      for (var i = 0; i < getLoggerList.length; i++) {
        loggerListItem.add(LoggerListComponent().renderLoggerListItems(context,
            getLoggerList[i].serNum, getLoggerList[i].description ??= ""));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // button action provider
    initLoggerList(context);
    final electricitySettings = Provider.of<ElectricitySettings>(context);
    String userName = electricitySettings.username;
    // animation providers
    final animProvider = Provider.of<DashboardAnimationProvider>(context);
    final pvToBatDotPosition = animProvider.pvToBatAnimationPositionVal;

    final psManager = Provider.of<PowerServiceManager>(context);
    final esManager = Provider.of<EnergyStorageServiceManager>(context);
    // _initWs(context);
    // _initPsManager(context);
    // _initEsManager(context);

    final energyEfficiencyPercentageTxt =
        psManager.energyEfficiencyPercentageTxt;
    //Calc value of energy eff with screen width value
    var energyLinePosition = (psManager.energyEfficiency / 100);
    // MediaQuery.of(context).size.width * 0.01;
    if (energyLinePosition == 0) {
      energyLinePosition = MediaQuery.of(context).size.width * 0.1 - 11;
    } else if (energyLinePosition < 1) {
      energyLinePosition = (psManager.energyEfficiency / 100) *
              MediaQuery.of(context).size.width *
              0.9 +
          11;
    } else {
      energyLinePosition = (psManager.energyEfficiency / 100) *
              MediaQuery.of(context).size.width *
              0.9 -
          11;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme:
            IconThemeData(color: FlutterFlowTheme.of(context).tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          Provider.of<DeviceManager>(context, listen: false)
              .getSelectedLogger!
              .description ??= "",
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
              padding: const EdgeInsetsDirectional.fromSTEB(25, 50, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Icon(
                      Icons.person_add,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            userName,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Rectangle_12.png',
                                width: 30,
                                height: 20,
                                fit: BoxFit.fitHeight,
                              ),
                              Text(
                                Provider.of<DeviceManager>(context,
                                        listen: false)
                                    .getSelectedLogger!
                                    .description ??= "",
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: loggerListItem,
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
              child: Container(
                constraints: const BoxConstraints(maxHeight: 690),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const DashbaordAnimationController(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        // height: 180,
                        constraints: BoxConstraints.loose(const Size(530, 180)),
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: buttonAction.moreInfoColor,
                          //     offset: Offset(0.0, buttonAction.offsetRadius),
                          //     //(x,y)
                          //     blurRadius: buttonAction.blurRadius,
                          //   ),
                          // ],
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.width,
                          // height:MediaQuery.of(context).size.height * 0.19,
                          child: Stack(
                            children: [
                              PageView(
                                controller: pageViewController ??=
                                    PageController(initialPage: 0),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Column(
                                    children: infoCard,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: const Color(0x00EEEEEE),
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: Image.asset(
                                          'assets/images/moneyBackground.png',
                                        ).image,

                                        // opacity: 0.5
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          DashInfoDFWidget(
                                              label: "Daily",
                                              icon: FaIcon(
                                                FontAwesomeIcons.coins,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 14,
                                              ),
                                              unit: "Rand",
                                              value: psManager.dailyFinancial),
                                          DashInfoDFWidget(
                                              label: "Monthly",
                                              icon: FaIcon(
                                                FontAwesomeIcons.coins,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 14,
                                              ),
                                              unit: "Rand",
                                              value:
                                                  psManager.monthlyFinancial),
                                          DashInfoDFWidget(
                                              label: "Total",
                                              icon: FaIcon(
                                                FontAwesomeIcons.coins,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 14,
                                              ),
                                              unit: "Rand",
                                              value: psManager.totalFinancial),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0, 1),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: SmoothPageIndicator(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    count: 2,
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
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DashboardAnimImage(
                                onTap: insertPVInfoCard,
                                icon: FaIcon(
                                  FontAwesomeIcons.solarPanel,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: 15,
                                ),
                                powerW:
                                    psManager.getLivePowerTypeMap["pv"]?.powerW,
                                ratedPowerW: psManager
                                    .getLivePowerTypeMap["pv"]?.ratedPowerW,
                                offset: -39,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: DashboardAnimImage(
                                    onTap: insertGridInfoCard,
                                    icon: Icon(
                                      Icons.offline_bolt_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 22,
                                    ),
                                    powerW: psManager
                                        .getLivePowerTypeMap["grid"]?.powerW,
                                    ratedPowerW: psManager
                                        .getLivePowerTypeMap["grid"]
                                        ?.ratedPowerW,
                                    fillColor: Colors.red,
                                    offset: -41,
                                  )),
                              Container(
                                width: 150,
                                height: 150,
                                // child: const SpinKitCircle(
                                //   color: Color(0xFFF2CC0D),
                                //   size: 100.0,
                                // ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FlutterFlowTheme.of(context)
                                        .dashboard!
                                        .image,
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Transform.translate(
                                      offset:
                                          Offset(71.5, pvToBatDotPosition - 80),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 1),
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
                                          animProvider
                                                  .gridAnimationPositionVal -
                                              15,
                                          1),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 1),
                                        child: Opacity(
                                          opacity: psManager.gridDotActive,
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
                                          animProvider
                                                  .loadAnimationPositionVal -
                                              -57.5,
                                          1),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 1),
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
                                      offset: Offset(
                                          50,
                                          animProvider
                                              .batChargeAnimationPositionVal),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 1),
                                        child: Opacity(
                                          opacity: esManager.batChargeDotActive,
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 1),
                                        child: Opacity(
                                          opacity:
                                              esManager.batDischargeDotActive,
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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 0),
                                      child: DashboardAnimImage(
                                        onTap: insertLoadInfoCard,
                                        icon: FaIcon(
                                          FontAwesomeIcons.house,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          size: 15,
                                        ),
                                        powerW: psManager
                                            .getLivePowerTypeMap["load"]
                                            ?.powerW,
                                        ratedPowerW: psManager
                                            .getLivePowerTypeMap["load"]
                                            ?.ratedPowerW,
                                        fillColor: Colors.blue,
                                        offset: -39,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // width: 100,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    DashboardAnimImage(
                                      onTap: insertBatInfoCard,
                                      icon: Icon(
                                        Icons.battery_charging_full_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        size: 16,
                                      ),
                                      powerW: esManager.sumData.powerW,
                                      ratedPowerW:
                                          esManager.sumData.ratedPowerW,
                                      fillColor: Colors.orange,
                                      offset: -38,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      MediaQuery.of(context).size.width * 0.085,
                                      0,
                                      5,
                                      0),
                                  child: Text(
                                    "Eco Score",
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
                                Row(
                                  // mainAxisSize: MainAxisSize.max,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      energyEfficiencyPercentageTxt,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color:
                                                psManager.energyEfficiencyColor,
                                            fontSize: 14,
                                          ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              1, 0, 0, 0),
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                                              color: psManager
                                                  .energyEfficiencyColor
                                                  .withOpacity(0.7),
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
                            visible: psManager.loader,
                            child: Transform.translate(
                              offset: const Offset(0, -332),
                              child: Container(
                                width: 150,
                                height: 151,
                                child: SpinKitCircle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 40.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
