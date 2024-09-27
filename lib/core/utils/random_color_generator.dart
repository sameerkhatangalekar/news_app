import 'dart:math';

import 'package:flutter/material.dart';
final List<Color> imagePlaceholderColors = [
  Colors.red.shade100,
  Colors.pink.shade100,
  Colors.purple.shade100,
  Colors.deepPurple.shade100,
  Colors.blue.shade100,
  Colors.cyan.shade100,
  Colors.teal.shade100,
  Colors.green.shade100,
  Colors.lightGreen.shade100,
  Colors.lime.shade100,
  Colors.yellow.shade100,
  Colors.amber.shade100,
  Colors.orange.shade100,
  Colors.deepOrange.shade100,
  Colors.brown.shade100,
  Colors.grey.shade100,
  Colors.blueGrey.shade100
];

Color getRandomColor() {
  final rand = Random();

  return imagePlaceholderColors[rand.nextInt(imagePlaceholderColors.length)];
}