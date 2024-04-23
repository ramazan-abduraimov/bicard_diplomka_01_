import 'package:flutter/material.dart';

import 'Verstka_/authorization/onboarding.dart';

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
