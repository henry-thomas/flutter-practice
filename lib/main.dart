import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/power_type_chart.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: WsManager(),
        ),
        ChangeNotifierProvider.value(
          value: PowerServiceManager(),
        ),
        ChangeNotifierProvider.value(
          value: ApiController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static var isWsInit = false;

  void _initWsManager(BuildContext context) {
    if (!isWsInit) {
      Provider.of<WsManager>(context, listen: false).initWsManager(context);
      isWsInit = true;
    }
  }

//Calling the login method in API controller, passing the state of this
//widget. We can later get the JWT from API controller class.
  Future _login(BuildContext context) async {
    await Provider.of<ApiController>(context, listen: false)
        .login(ApiController.USERNAME, ApiController.PASSWORD, context);
  }

  static int reqId = 0;
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<PowerServiceManager>(context).count;

    //This is how we get the values form a provider/
    var powerTypeMap =
        Provider.of<PowerServiceManager>(context).getPowerTypeMap;

    //This should be called from the login page, ofcourse.
    //This is how we call a method from a provider.

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            PowerTypeChart.withSampleData(powerTypeMap)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _startRandom(context),
        onPressed: () async {
          // debugPrint(powerTypeMap.toString());
          // _initWsManager(context);
          await _login(context);

          debugPrint(powerTypeMap.toString());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
