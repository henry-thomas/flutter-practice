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
  AnimationController ?gridController;
  AnimationController ?loadController;
  AnimationController ?batChargeController;
  AnimationController ?batDischargeController;


  @override
  void initState() {
    super.initState();
    pvToBatAnim();
    gridAnim();
    loadAnim();
    batChargeAnim();
    batDischargeAnim();
  }

  pvToBatAnim() async {
    final pvtoBatProvider = Provider.of<DashboardAnimationProvider>(context,listen:false);
    pvToBatController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this, upperBound: 80);
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


  gridAnim() async {
    final pvtoBatProvider = Provider.of<DashboardAnimationProvider>(context,listen:false);
    gridController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this, upperBound: 80);
    animation = CurvedAnimation(parent: gridController!, curve: Curves.decelerate);
    gridController?.forward();
    animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        gridController?.forward(from: -73);
      }
    });
    gridController?.addListener(() {
      pvtoBatProvider.setGridAnim(gridController?.value);
      // pvToBatPositionVal = pvToBatController!.value!;

    });
  }

  loadAnim() async {
    final pvtoBatProvider = Provider.of<DashboardAnimationProvider>(context,listen:false);
    loadController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this, upperBound: 80);
    animation = CurvedAnimation(parent: loadController!, curve: Curves.decelerate);
    loadController?.forward();
    animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        loadController?.forward(from: -73);
      }
    });
    loadController?.addListener(() {
      pvtoBatProvider.setLoadAnim(loadController?.value);
      // pvToBatPositionVal = pvToBatController!.value!;

    });
  }

  batChargeAnim() async {
    final pvtoBatProvider = Provider.of<DashboardAnimationProvider>(context,listen:false);
    batChargeController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this, upperBound: 80);
    animation = CurvedAnimation(parent: batChargeController!, curve: Curves.decelerate);
    batChargeController?.forward();
    animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        batChargeController?.forward(from: -73);
      }
    });
    batChargeController?.addListener(() {
      pvtoBatProvider.setBatChargeAnim(batChargeController?.value);
      // pvToBatPositionVal = pvToBatController!.value!;

    });
  }

  batDischargeAnim() async {
    final pvtoBatProvider = Provider.of<DashboardAnimationProvider>(context,listen:false);
    batDischargeController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this, upperBound: 72);
    animation = CurvedAnimation(parent: batDischargeController!, curve: Curves.decelerate);
    batDischargeController?.reverse(from: 72);
    animation?.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        batDischargeController?.reverse(from: 72);
      }
    });
    batDischargeController?.addListener(() {
      pvtoBatProvider.setBatDischargeAnim(batDischargeController?.value);
      // pvToBatPositionVal = pvToBatController!.value!;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
@override
dispose() {
  pvToBatController?.dispose();
  gridController?.dispose();
  loadController?.dispose();
  batChargeController?.dispose();
  batDischargeController?.dispose();
  super.dispose();
}
}

