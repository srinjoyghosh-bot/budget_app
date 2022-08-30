import 'package:flutter/material.dart';

class ChartData {
  ChartData({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final double value;
  final Color color;
}
