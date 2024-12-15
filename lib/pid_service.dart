import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';

class PidService{
  late Timer dataGenerationTimer;
  List<FlSpot> dataPoints = [];
  double setPoint = 0.0;
  double currentValue = 10;
  double lastError = 0.0;
  double integral = 0.0;

  double minY = 0;
  double maxY = 0;

  //gains
  double kP = 1.2;
  double kI = 0.01;
  double kD = 0.0;


  updateValues() {
    double error = setPoint - currentValue;
    integral += error;

    double proportionalOutput = error * kP;

    double derivativeOutput = (error - lastError) * kD;

    double integralOutput = integral * kI;

    currentValue += (integralOutput + derivativeOutput + proportionalOutput);

    lastError = error;


    setYAxis();

    // Add new data point
    dataPoints.add(FlSpot(dataPoints.length.toDouble(), currentValue));

    // Limit number of points to prevent performance issues
    if (dataPoints.length > 50) {
      // dataPoints.removeAt(0);
    }
  }

    void setYAxis() {
      minY = min(minY, (min(currentValue, setPoint) - 1));
      maxY = max(maxY, (max(currentValue, setPoint) + 1));
    }



  //boiler plate to make a singleton
  static final PidService _instance = PidService._internal();

  // Factory constructor returns the single instance
  factory PidService() {
    return _instance;
  }
    // Private named constructor
  PidService._internal();
}