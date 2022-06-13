import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/providers/device_manager.dart';
import 'package:provider_test/providers/power_type_chart_manager.dart';
import 'package:provider_test/providers/websocket/es_manager.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';
import 'package:provider_test/screens/chartScreen/chartComponents/chart_actions.dart';
import 'package:provider_test/screens/chartScreen/chart_controller.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardAnimation/dashboard_animation_provider.dart';
import 'package:provider_test/screens/dashboardScreen/dashboardComponents/dashboard_button_actions.dart';
import 'package:provider_test/screens/weatherScreen/weatherControllers/weather_controller.dart';
import 'flutterFlow/flutter_flow_theme.dart';
import 'screens/loginScreen/login_page_view.dart';
import 'screens/weatherScreen/weatherControllers/weather_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ButtonAction(),
        ),
        ChangeNotifierProvider.value(
          value: weatherController(),
        ),
        // ChangeNotifierProvider.value(
        //   value: WeatherApi(),
        // ),
        ChangeNotifierProvider.value(
          value: DashboardAnimationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WsManager(),
        ),
        ChangeNotifierProvider.value(
          value: PowerServiceManager(),
        ),
        ChangeNotifierProvider.value(
          value: ApiController(),
        ),
        ChangeNotifierProvider.value(
          value: DeviceManager(),
        ),
        ChangeNotifierProvider.value(
          value: EnergyStorageServiceManager(),
        ),
        ChangeNotifierProvider.value(
          value: ChartController(),
        ),
        ChangeNotifierProvider.value(
          value: PowerTypeChartDataManager(),
        ),ChangeNotifierProvider.value(
          value: chartActions(),
        ),
      ],
      child: MaterialApp(
        title: 'myPower24',
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: _themeMode,
        color: Colors.red,
        home: const LoginPageWidget(),

      ),
    );
  }
}

