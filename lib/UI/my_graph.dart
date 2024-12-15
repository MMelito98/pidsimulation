import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_app/pid_service.dart';

class MyGraph extends StatefulWidget {
  const MyGraph({super.key});

  @override
  State<MyGraph> createState() => _MyGraphState();
}

class _MyGraphState extends State<MyGraph> {
  late PidService pidService;

  @override
  Widget build(BuildContext context) {
    pidService.setYAxis();
    return LineChart(
        LineChartData(minY: PidService().minY, maxY: pidService.maxY, lineBarsData: [
      LineChartBarData(
        spots: pidService.dataPoints,
        isCurved: true,
        color: Colors.blue,
      )
    ]));
  }


  @override
  void initState() {
    pidService = PidService();

    //setting up the timer
    pidService.dataGenerationTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        pidService.updateValues();
      });
    });

    pidService.dataPoints.add(FlSpot(0, pidService.currentValue));

    super.initState();
  }
}
