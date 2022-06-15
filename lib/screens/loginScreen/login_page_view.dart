import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'login_components.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  TextEditingController? emailAddressController;
  TextEditingController? passwordController;
  bool? passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    var usernameInput = "Henry_Thomas"; // emailAddressController!.text;
    var passwordInput = "123456"; // passwordController!.text;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: FlutterFlowTheme.of(context).loginCover!.image,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-90, 35),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 1),
                                    child: Opacity(
                                        opacity: 0.5,
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
                                            width: 29,
                                            height: 29,
                                            child: Center(
                                              child: Icon(
                                                Icons.offline_bolt_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-84, 36),
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: Colors.red,
                                        size: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-67, -30),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 1),
                                    child: Opacity(
                                        opacity: 0.5,
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
                                            width: 29,
                                            height: 29,
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.solarPanel,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-84, 0),
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: Colors.green,
                                        size: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-102, 130),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 1),
                                    child: Opacity(
                                        opacity: 0.5,
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
                                            width: 29,
                                            height: 29,
                                            child: Center(
                                                child: Icon(
                                              Icons
                                                  .battery_charging_full_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              size: 12,
                                            )),
                                          ),
                                        )),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-120, 105),
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: Colors.orange,
                                        size: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(80, 35),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 1),
                                    child: Opacity(
                                        opacity: 0.5,
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
                                            width: 29,
                                            height: 29,
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.house,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(25, 37),
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: Colors.blue,
                                        size: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-30, 37),
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Opacity(
                                      opacity: 0.4,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: Colors.blue,
                                        size: 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 60),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 240,
                                    height: 60,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 0),
                              child: TextFormField(
                                controller: emailAddressController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Enter your Username...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 20, 24),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 12, 20, 0),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: !passwordVisibility!,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Enter your password...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 20, 24),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility!,
                                    ),
                                    child: Icon(
                                      passwordVisibility!
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 0),
                              child: LoginComponents.loginBtn(
                                  usernameInput, passwordInput, context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
