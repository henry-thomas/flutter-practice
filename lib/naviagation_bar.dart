import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/device_manager.dart';
import 'package:provider_test/providers/energy_chart_manager.dart';
import 'package:provider_test/providers/power_type_chart_manager.dart';
import 'package:provider_test/providers/websocket/es_manager.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';
import 'package:provider_test/screens/chartScreen/chartComponents/chart_actions.dart';
import 'package:provider_test/screens/chartScreen/chart_page_view.dart';
import 'package:provider_test/screens/dashboardScreen/dashboard_page_view.dart';
import 'package:provider_test/screens/profileScreen/profile_page_view.dart';

import 'flutterFlow/flutter_flow_theme.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key, this.initialPage}) : super(key: key);

  final String? initialPage;
  final Widget dashboard = const DashboardWidget();
  final Widget charts = const ChartsPageView();
  final Widget profile = const ProfilePageView();

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'DashboardPage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  bool isWsInit = false;
  void _initWs(BuildContext context) {
    if (!isWsInit) {
      isWsInit = true;
      Provider.of<WsManager>(context, listen: false).initWs(context);
    }
  }

  bool isPsInit = false;
  bool isEsInit = false;

  bool _initPsManager(BuildContext context) {
    if (!isPsInit) {
      isPsInit = true;
      Provider.of<PowerServiceManager>(context, listen: false).init(context);
      return true;
    }

    return false;
  }

  bool _initEsManager(BuildContext context) {
    if (!isEsInit) {
      isEsInit = true;
      Provider.of<EnergyStorageServiceManager>(context, listen: false)
          .init(context);
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'DashboardPage': widget.dashboard,
      'ChartPage': widget.charts,
      'ProfilePage': widget.profile,
    };
    // final tabs = {
    //   'DashboardPage': widget.dashboard,
    //   'ChartPage': widget.charts,
    //   'ProfilePage': widget.profile,
    // };

    Provider.of<PowerTypeChartDataManager>(context, listen: false)
        .getPowerTypesFromDateRange(
            context, Provider.of<DeviceManager>(context).getSelectedLogger!);
    Provider.of<EnergyChartManager>(context, listen: false)
        .getEnergyDataForPeriod(
            context, Provider.of<DeviceManager>(context).getSelectedLogger!);

    _initPsManager(context);
    _initEsManager(context);
    _initWs(context);

    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: SizedBox(
        height: 53,
        child: BottomNavigationBar(
          elevation: 4,
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              // Provider.of<PowerTypeChartDataManager>(context, listen: false)
              //     .getPowerTypesFromDateRange(context);
              _currentPage = tabs.keys.toList()[i];
              Provider.of<ChartActions>(context, listen: false).onPageLeave();
              Provider.of<DeviceManager>(context, listen: false)
                  .updateLoggerStat(context);
            });
          },
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          selectedItemColor: FlutterFlowTheme.of(context).primaryColor,
          unselectedItemColor: const Color(0x8A000000),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.speed_sharp,
                size: 20,
              ),
              label: 'DashboardPage',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.chartPie,
                size: 15,
              ),
              label: 'ChartPage',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                size: 20,
              ),
              label: 'ProfilePage',
              tooltip: '',
            ),
          ],
        ),
      ),
    );
  }
}
