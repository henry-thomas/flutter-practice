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
  static String jwt =
      "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxIiwic2NlIjoibW9iaWxlIn0.fMb0gvTNuicGeccoT39psw7KHm6Zw_rw2bA0lK0_kCUwUAL977vNtS74X87l1BTt38oPT0PrVinxgfI157Xrr2IsVNP40PWl4Iqzt2XjoXCBVmhhc94ZCDp4iq7KswdHMWvO-CGY5Cmdx3xDheJcAyuvoMrifmkFLfPIU9f-KGBJVQRsTjdD-yLWUBZSOhusHBe4uz867ClSDLTAszwmZC-MtTuzut51ND7SsEo18GsmTXQfqnAYDi8sh2Hu2KHfWTZNMd1cPlh2aAq1SFsjccMzSdK84bXLdy88Pg6zkdHC05Lhpvm0ncICWbhxRq-0tVDZoqLsS6mrlbacXb8Ylg";
  static String url = 'ws://192.168.100.18:8084/SolarMDApi/mobile?token=' +
      jwt +
      '&loggerSerial=' +
      loggerSerial +
      '&deviceModel=' +
      devModel;

  static final channel = WebSocketChannel.connect(Uri.parse(url));

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  void _incrementCounter(BuildContext context) {
    Provider.of<WsManager>(context, listen: false).incrementCounter();
  }

  void _startRandom(BuildContext context) {
    Provider.of<WsManager>(context, listen: false).startRandom();
  }

  void _processMessage(BuildContext context, Map<String, dynamic> msg,
      WebSocketChannel channel) {
    Provider.of<WsManager>(context, listen: false)
        .processMessage(msg, channel, context);
  }

  void _login(BuildContext context) {
    Provider.of<ApiController>(context, listen: false)
        .login(ApiController.USERNAME, ApiController.PASSWORD, context);
  }

  void _initPsManager(BuildContext context) {
    Provider.of<PowerServiceManager>(context, listen: false).init(context);
  }

  static int reqId = 0;
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<WsManager>(context).getRandom;

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
        onPressed: () => {_login(context), _initPsManager(context)},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
