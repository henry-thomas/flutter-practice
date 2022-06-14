

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';
import '../profileSettings/electricity_settings.dart';

class ElectricPriceInputComponent extends StatefulWidget {
  const ElectricPriceInputComponent({Key? key}) : super(key: key);

  @override
  State<ElectricPriceInputComponent> createState() => _ElectricPriceInputComponentState();
}

class _ElectricPriceInputComponentState extends State<ElectricPriceInputComponent> {
  TextEditingController? electricPriceInputController;

  @override
  void initState() {
    // TODO: implement initState
    electricPriceInputController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final electricitySettings = Provider.of<ElectricitySettings>(context);
    return   Row(
      children: [
        Icon(
          Icons.power,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 16,
        ),

        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
          child: SizedBox(
            height: 50,
            width: 170,
            child: TextField(
              controller: electricPriceInputController,
              decoration:  InputDecoration(
                  labelStyle:  FlutterFlowTheme.of(context)
                      .bodyText1
                      .override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context)
                        .secondaryText,
                    fontSize: 11,
                  ),
                  labelText: "Electricity Price"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter
              ], // Only numbers can be entered
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(65, 0, 0, 0),
          child: InkWell(
            child: Icon(
                    Icons.done_rounded,
                    color:FlutterFlowTheme.of(context).secondaryText,
                    size: 24,
                  ),
            onTap: () {
              electricitySettings.insertElectricPriceInput();
              var newElectricitiyPrice = electricPriceInputController!.text;
              print(newElectricitiyPrice);
              electricitySettings.setElectricityPrice(newElectricitiyPrice);
              final snackBar = SnackBar(
                  backgroundColor:FlutterFlowTheme.of(context).secondaryBackground,
                  content: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Electricity price Changed to R$newElectricitiyPrice",
                        style: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context)
                              .secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      Icon(
                        Icons.done_rounded,
                        color:FlutterFlowTheme.of(context).primaryColor,
                        size: 24,
                      )
                    ],
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
      ],
    );
  }
}
