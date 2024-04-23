import 'dart:async';

import 'package:bicard_diplomka_01_/Verstka_/authorization/sign_in.dart';
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
    Timer(Duration(seconds: 5), () {
      // Переход на следующий экран после 2 секунд ожидания
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(
          "asset/images/Image1.png",
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 25,
        ),
        Text("Знакомьтесь с врачами онлайн"),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: Text(
              "Общайтесь со специализированными врачами онлайн для получения удобных и всесторонних медицинских консультаций."),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen2()));
            },
            child: Text(
              "Дальше",
            )),
        SizedBox(
          height: 30,
        ),
        Image.asset("asset/images/Carousel.png")
      ]),
    );
  }
}

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(
          "asset/images/Image2.png",
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 25,
        ),
        Text("Общайтесь со специалистами"),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: Text(
              "Общайтесь со специализированными врачами онлайн для получения удобных и всесторонних медицинских консультаций."),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen3()));
            },
            child: Text(
              "Дальше",
            )),
        SizedBox(
          height: 30,
        ),
        Image.asset("asset/images/Carousel_2.png")
      ]),
    );
  }
}

class HomeScreen3 extends StatelessWidget {
  const HomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(
          "asset/images/Image3.png",
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 25,
        ),
        Text("Тысячи онлайн-специалистов"),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: Text(
              "Изучите широкий спектр медицинских онлайн-специалистов, предлагающих широкий спектр экспертных знаний с учетом Ваших потребностей в области здравоохранения."),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignIn()));
            },
            child: Text(
              "Дальше",
            )),
        SizedBox(
          height: 30,
        ),
        Image.asset("asset/images/Carousel_3.png")
      ]),
    );
  }
}
