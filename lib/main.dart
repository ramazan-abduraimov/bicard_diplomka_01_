import 'package:bicard_diplomka_01_/Verstka_/authorization/01_information/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:bicard_diplomka_01_/Verstka_/proba.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Onboarding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
