import 'package:flutter/material.dart';
import 'package:provider_test/flutterFlow/flutter_flow_theme.dart';
import 'package:provider_test/flutterFlow/flutter_flow_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';

class LoginComponents {
  static void errorDialog(context) {
    _showMyDialog(context);
  }

  static void _login(String username, String password, BuildContext context) {
    Provider.of<ApiController>(context, listen: false)
        .login(username, password, context);
  }

  // failed login wigdet compnent
 static Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF2CC0D).withOpacity(0.9),
          title: const Text('Login unsuccessful'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Incorrect UserName or Password'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static FFButtonWidget loginBtn(username,password,context) {
    return FFButtonWidget(
      onPressed: () async {
        _login(username,password,context);
      },
      text: 'Login',
      options: FFButtonOptions(
        width: 230,
        height: 60,
        color:FlutterFlowTheme.of(context).primaryBackground,
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
          fontFamily: 'Lexend Deca',
          color: FlutterFlowTheme.of(context).primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        elevation: 7,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: 8,
      ),
    );
  }
}


