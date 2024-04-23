import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SMSCodeScreen extends StatefulWidget {
  @override
  _SMSCodeScreenState createState() => _SMSCodeScreenState();
}

class _SMSCodeScreenState extends State<SMSCodeScreen> {
  List<String> codeList = List.generate(6, (index) => "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter SMS Code'),
      ),
      body: Center(
        child: Column(
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
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 40,
                    height: 40,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length <= 1) {
                          setState(() {
                            codeList[index] = value;
                          });
                          if (index < 5 && value.isNotEmpty) {
                            FocusScope.of(context).nextFocus();
                          }
                        }
                      },
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
