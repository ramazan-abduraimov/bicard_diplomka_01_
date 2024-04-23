import 'package:bicard_diplomka_01_/Verstka_/authorization/forget_password.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Image.asset("asset/images/Vector.png"),
          SizedBox(
            height: 10,
          ),
          Text("Друг здоровья"),
          Text("Привет, с возвращением!"),
          Text("Надеюсь, у тебя все хорошо."),
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
          ElevatedButton(onPressed: () {}, child: Text("войти")),
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
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgetPassword()));
              },
              child: Text("Забыли пароль?")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("У вас еще нет учетной записи?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: Text("Pегистрация"))
            ],
          )
        ],
      )),
    );
  }
}
