import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/power_type_chart_manager.dart';
import 'package:provider_test/screens/chartScreen/chart_page_view.dart';
import 'package:provider_test/screens/dashboardScreen/dashboard_page_view.dart';

import 'flutterFlow/flutter_flow_theme.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage}) : super(key: key);

  final String? initialPage;

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

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'DashboardPage': const DashboardWidget(),
      'ChartPage': const ChartsPageView(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          elevation: 4,
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              Provider.of<PowerTypeChartDataManager>(context, listen: false)
                  .getPowerTypesFromDateRange(context);
              _currentPage = tabs.keys.toList()[i];
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
              label: 'Dashboard',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.chartPie,
                size: 15,
              ),
              label: 'Charts',
              tooltip: '',
            ),
          ],
        ),
      ),
    );
  }
}
