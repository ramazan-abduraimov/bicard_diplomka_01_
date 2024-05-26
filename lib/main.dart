import 'package:bicard_diplomka_01_/Verstka_/authorization/01_information/onboarding.dart';
import 'package:bicard_diplomka_01_/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
      ],
      child: const MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,],
        supportedLocales: [
          Locale('en'), // English US
          Locale('ru'), // English UK
        ],
        home: Onboarding(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
