import 'package:bicard_diplomka_01_/Verstka_/authorization/FillYourProfile.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("asset/images/Vector.png"),
            Text("Друг здоровья"),
            Text("Cоздать аккаунт"),
            Text("Мы здесь, чтобы помочь вам!"),
            Padding(
              padding: const EdgeInsets.fromLTRB(48, 20, 47, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    prefixIcon: Icon(Icons.account_box),
                    labelText: "Ваше имя"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: "Электронной почты"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Пароль"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FillYourProfile()));
                },
                child: Text(
                  "Cоздать аккаунт",
                )),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("asset/images/Google - Original.png"),
                  Text("   Продолжайте работать с Google")
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("asset/images/_Facebook.png"),
                  Text("   Продолжайте с Facebook")
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("У вас есть учетная запись?"),
                TextButton(onPressed: () {}, child: Text("Bойти"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
