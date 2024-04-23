import 'package:bicard_diplomka_01_/Verstka_/authorization/SmsCodeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("asset/images/Vector.png"),
            SizedBox(
              height: 10,
            ),
            Text("Друг здоровья"),
            Text("Забыли пароль?"),
            Text("Введите свой адрес электронной почты, мы вышлем"),
            Text("вам проверочный код."),
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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SMSCodeScreen()));
                },
                child: Text("Отправить код")),
          ],
        ),
      ),
    );
  }
}
