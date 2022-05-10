import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_animation_provider.dart';

class DashbaordAnimationController extends StatefulWidget {
  const DashbaordAnimationController({Key? key}) : super(key: key);

  @override
  State<DashbaordAnimationController> createState() => _DashbaordAnimationControllerState();
}

class _DashbaordAnimationControllerState extends State<DashbaordAnimationController>  with TickerProviderStateMixin
{



  Animation ?animation;
  AnimationController ?pvToBatController;

 double pvToBatPositionVal = 0;

  @override
  void initState() {
    super.initState();
    pvToBatAnim();
  }

  pvToBatAnim() async {
    final pvtoBatProvider = Provider.of<DashboardAnimationProvider>(context,listen:false);
    pvToBatController = AnimationController(
        duration: Duration(seconds: 2), vsync: this, upperBound: 140);
    animation = CurvedAnimation(parent: pvToBatController!, curve: Curves.decelerate);
    pvToBatController?.forward();
    animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        pvToBatController?.forward(from: -73);
      }
    });
    pvToBatController?.addListener(() {
pvtoBatProvider.setPvToBatAnim(pvToBatController?.value);
        // pvToBatPositionVal = pvToBatController!.value!;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}

