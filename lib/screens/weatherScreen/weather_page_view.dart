// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:provider_test/screens/chartScreen/chart_page_view.dart';
// import 'package:provider_test/screens/weatherScreen/weatherComponents/weather_components_controller.dart';
// import 'package:provider_test/screens/weatherScreen/weatherControllers/weather_controller.dart';

// import '../../flutterFlow/flutter_flow_theme.dart';
// import '../EventsScreen/events_page_view.dart';
// import '../dashboardScreen/dashboard_page_view.dart';
// import '../loginScreen/login_page_view.dart';
// import 'weatherControllers/weather_api.dart';

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({Key? key}) : super(key: key);

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   final bool _showFab = true;
//   final bool _showNotch = true;
//   final FloatingActionButtonLocation _fabLocation =
//       FloatingActionButtonLocation.endDocked;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   bool switchValue = false;
//   String? selectedValue;
//   List<String> items = [
//     'Logout',
//   ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var weatherCover =
//         FlutterFlowTheme.of(context).weatherNightClearCover!.image;
//     checkWeatherBackgroundValue() {
//       final weatherProvider = Provider.of<weatherController>(
//         context,
//         listen: false,
//       );
//       if (weatherProvider.weatherBackground == "Night") {
//         weatherCover =
//             FlutterFlowTheme.of(context).weatherNightClearCover!.image;
//       }
//     }

//     final weatherData = Provider.of<WeatherApi>(
//       context,
//       listen: false,
//     );
//     weatherData.queryWeather();
//     // weatherData.queryForecast();
//     final temp = weatherData.temp;
//     final hoursTillSunset = weatherData.hoursTillSunset;
//     final minutsTillSunset = weatherData.minutsTillSunset;
//     return Scaffold(
//       bottomNavigationBar: BottomAppBar(
//         shape: _showNotch ? const CircularNotchedRectangle() : null,
//         color:  FlutterFlowTheme.of(context).weatherTimeColor?.withOpacity(0.7),
//         child: IconTheme(
//           data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               IconButton(
//                 tooltip: 'Dashboard',
//                 splashColor: Colors.white,
//                 icon: Icon(
//                   Icons.speed_sharp,
//                   color: FlutterFlowTheme.of(context).tertiaryColor,
//                   size: 24,
//                 ),
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const DashboardWidget();
//                   }));
//                 },
//               ),
//               // if (centerLocations.contains(fabLocation)) const Spacer(),
//               IconButton(
//                 tooltip: 'Weather',
//                 icon: FaIcon(
//                   FontAwesomeIcons.cloudSun,
//                   color:Colors.white,
//                   size: 20,
//                 ),
//                 // icon: Icon(
//                 //   Icons.dashboard,
//                 //   color: FlutterFlowTheme.of(context).tertiaryColor,
//                 //   size: 22,
//                 // ),
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const WeatherPage();
//                   }));
//                 },
//               ),
//               IconButton(
//                 tooltip: 'Events',
//                 icon: Icon(
//                   Icons.event,
//                   color: FlutterFlowTheme.of(context).tertiaryColor,
//                   size: 20,
//                 ),
//                 // icon: Icon(
//                 //   Icons.dashboard,
//                 //   color: FlutterFlowTheme.of(context).tertiaryColor,
//                 //   size: 22,
//                 // ),
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const EventsPageView();
//                   }));
//                 },
//               ),
//               IconButton(
//                 tooltip: 'Charts',
//                 icon: FaIcon(
//                   FontAwesomeIcons.chartPie,
//                   color: FlutterFlowTheme.of(context).tertiaryColor,
//                   size: 18,
//                 ),
//                 // icon: Icon(
//                 //   Icons.dashboard,
//                 //   color: FlutterFlowTheme.of(context).tertiaryColor,
//                 //   size: 22,
//                 // ),
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const ChartsPageView();
//                   }));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         iconTheme:
//         IconThemeData(color: FlutterFlowTheme.of(context).tertiaryColor),
//         automaticallyImplyLeading: true,
//         title: Text(
//           "Weather",
//           style: FlutterFlowTheme.of(context).bodyText1,
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton2(
//                 isExpanded: true,
//                 hint: Row(
//                   children: const [
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Expanded(
//                       child: Text(
//                         '',
//                         style: TextStyle(
//                           fontSize: 0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 items: items
//                     .map((item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: FlutterFlowTheme.of(context).bodyText1,
//                   ),
//                 ))
//                     .toList(),
//                 value: selectedValue,
//                 onChanged: (value) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const LoginPageWidget(),
//                     ),
//                   );
//                 },
//                 icon: Image.asset(
//                   'assets/images/g865.png',
//                   width: 70,
//                   height: 70,
//                   fit: BoxFit.fitWidth,
//                 ),
//                 buttonHeight: 20,
//                 buttonWidth: 100,
//                 buttonDecoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).primaryBackground,
//                 ),
//                 buttonElevation: 0,
//                 itemHeight: 20,
//                 dropdownMaxHeight: 100,
//                 dropdownWidth: 100,
//                 dropdownPadding: null,
//                 dropdownDecoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).primaryBackground,
//                 ),
//                 dropdownElevation: 0,
//                 offset: const Offset(10, 0),
//               ),
//             ),
//           ),
//         ],
//         centerTitle: true,
//         elevation: 4,
//       ),
//       key: scaffoldKey,
//       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//       body: SafeArea(
//         child: SingleChildScrollView(
//             child: Column(
//           children: [
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.9,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   fit: BoxFit.fitWidth,
//                   image: weatherCover,
//                 )),
//                 child: Column(children: [
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               weatherData.weatherDescription,
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white70,
//                                     fontSize: 21,
//                                   ),
//                             ),
//                             Row(
//                               children: [
//                                 weatherData.weatherIcon,
//                                 Text(
//                                   "$temp°C",
//                                   style: FlutterFlowTheme.of(context)
//                                       .bodyText1
//                                       .override(
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.white.withOpacity(0.9),
//                                         fontSize: 41,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               "$hoursTillSunset Hours and $minutsTillSunset Minutes till Sunset",
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white70,
//                                     fontSize: 21,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 220, 0, 0),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "CAPE TOWN",
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w600,
//                                     color: FlutterFlowTheme.of(context)
//                                         .weatherTimeColor
//                                         ?.withOpacity(0.7),
//                                     fontSize: 21,
//                                   ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 1,
//                             color: FlutterFlowTheme.of(context)
//                                 .weatherTimeColor
//                                 ?.withOpacity(0.7),
//                           ),
//                         ),
//                         Container(
//                           height: 270,
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.vertical,
//                             child: Column(
//                               children: WeatherUIController().weatherInfoList,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ]))
//           ],
//         )),
//       ),
//     );
//   }
// }
