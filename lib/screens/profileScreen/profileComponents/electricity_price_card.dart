

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../profileSettings/electricity_settings.dart';

class ElectricityPriceComponent extends StatefulWidget {
  const ElectricityPriceComponent({Key? key}) : super(key: key);

  @override
  State<ElectricityPriceComponent> createState() => _ElectricityPriceComponentState();
}

class _ElectricityPriceComponentState extends State<ElectricityPriceComponent> {



  @override
  Widget build(BuildContext context) {
    final electricitySettings = Provider.of<ElectricitySettings>(context);
    String electricityPrice = electricitySettings.electricityPrice.toString();

    return
    // Row(
    //   mainAxisSize: MainAxisSize.max,
    //   children: [

        Row(
          children: [
            Icon(
              Icons.power,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 16,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Text(
                'Electricity Price: R$electricityPrice per kWh',
                style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Outfit',
                  color:FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
              child: InkWell(
                child:   Icon(
                  Icons.arrow_forward_ios,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 18,
                ),
                onTap: () {
                  electricitySettings.insertElectricPriceInput();

                  // final snackBar = SnackBar(
                  //     backgroundColor:FlutterFlowTheme.of(context).secondaryBackground,
                  //     content: Row(
                  //       mainAxisSize: MainAxisSize.max,
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Text("Electricity price Changed",
                  //           style: FlutterFlowTheme.of(context)
                  //               .bodyText1
                  //               .override(
                  //             fontFamily: 'Poppins',
                  //             color: FlutterFlowTheme.of(context)
                  //                 .secondaryText,
                  //             fontSize: 11,
                  //           ),
                  //         ),
                  //         Icon(
                  //           Icons.done_rounded,
                  //           color:FlutterFlowTheme.of(context).primaryColor,
                  //           size: 24,
                  //         )
                  //       ],
                  //     ));
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),

          ],
        );



  }
}
