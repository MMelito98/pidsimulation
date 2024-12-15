import 'package:flutter/material.dart';
import 'package:my_app/UI/my_graph.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:my_app/pid_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PidService pidService;
  late TextEditingController setPointController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Row(children: [
          Expanded(
            flex: 6,
            child: MyGraph(),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("SetPoint"),
                TextField(
                  controller: setPointController,
                  onSubmitted: (value) {
                    pidService.setPoint = double.parse(value);
                  },
                ),
                ElevatedButton(onPressed: _pausePlot, child: Text("Pause"))
              ],
            ),
          )
        ]));
  }

  _pausePlot() {
    pidService.dataGenerationTimer.cancel();
  }

  @override
  void initState() {
    pidService = PidService();
    setPointController =
        TextEditingController(text: pidService.setPoint.toStringAsFixed(2));
    super.initState();
  }
}
