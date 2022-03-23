import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Exercises {
  Exercises({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.gif,
    this.seconds,
  });
  late final String id;
  late final String title;
  late final String thumbnail;
  late final String gif;
  final String? seconds;
}

final spinkit = SpinKitSpinningLines(
  color: Colors.red,
);
