import 'dart:async';

import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      // Переход на следующий экран после 2 секунд ожидания
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 114, 171, 218),
      body: Center(
        child: Image.asset("asset/images/bicard_logo_.jpg"),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<String> _images = [
    'asset/images/Image1.png',
    'asset/images/Image2.png',
    'asset/images/Image3.png',
  ];
  List<String> _texts = [
    'Знакомьтесь с врачами онлайн',
    'Общайтесь со специалистами',
    'Тысячи онлайн-специалистов',
  ];
  List<String> _texts_2 = [
    'Общайтесь со специализированными врачами онлайн для получения удобных и всесторонних медицинских консультаций.',
    'Общайтесь со специализированными врачами онлайн для получения удобных и всесторонних медицинских консультаций.',
    'Ознакомьтесь с широким спектром медицинских онлайн-специалистов, предлагающих широкий спектр экспертных знаний, адаптированных к Вашим потребностям в области здравоохранения.',
  ];


  void _incrementCounter() {
    setState(() {
      if (_counter < 2) {
        _counter++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
            SizedBox(
            height: MediaQuery.of(context).size.height / 1.7, // Half of screen height
            child: AspectRatio(
              aspectRatio: 10 / 9, // Adjust the aspect ratio as needed
              child: Image.asset(
                _images[_counter],
                fit: BoxFit.cover, // To cover the entire space
                alignment: Alignment.topCenter, // Align bottom
              ),
            ),
            ),
                SizedBox(height: 20),
                Text(_texts[_counter],style: TextStyle(fontSize: 20, fontFamily: "Schyler"),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      _texts_2[_counter],
                      textAlign: TextAlign.center, // Align text to center
                    ),
                  ),
                ),



                SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(109, 72, 255, 0.95),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(350, 50)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: _incrementCounter,
                  child: Text('Next'),
                ),

                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignIn(),
                        ),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
