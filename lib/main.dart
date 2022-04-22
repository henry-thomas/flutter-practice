import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
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
  static String loggerSerial = "MP-1623061258731";
  static String devModel = "12";
  static String url = 'ws://192.168.100.18:8084/SolarMDApi/mobile?token=' +
      ApiController.jwt +
      '&loggerSerial=' +
      loggerSerial +
      '&deviceModel=' +
      devModel;

  static final channel = WebSocketChannel.connect(Uri.parse(url));

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  void _processMessage(BuildContext context, Map<String, dynamic> msg,
      WebSocketChannel channel) {
    Provider.of<WsManager>(context, listen: false)
        .processMessage(msg, channel, context);
  }

//Calling the login method in API controller, passing the state of this
//widget. We can later get the JWT from API controller class.
  void _login(BuildContext context) {
    Provider.of<ApiController>(context, listen: false)
        .login(ApiController.USERNAME, ApiController.PASSWORD, context);
  }

  static int reqId = 0;
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<WsManager>(context).getRandom;

    //This is how we get the values form a provider/
    var powerTypeMap =
        Provider.of<PowerServiceManager>(context).getPowerTypeMap;

    //This should be called from the login page, ofcourse.
    //This is how we call a method from a provider.
    _login(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _startRandom(context),
        onPressed: () {
          debugPrint(powerTypeMap.toString());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
