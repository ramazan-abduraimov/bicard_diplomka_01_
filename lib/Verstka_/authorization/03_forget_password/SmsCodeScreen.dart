import 'package:bicard_diplomka_01_/Verstka_/authorization/03_forget_password/new_password.dart';
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
      appBar: AppBar( leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
        title: Text('Enter SMS Code'),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              children: [
                SizedBox(height: 25,),
                Image.asset("asset/images/Vector.png"),
                SizedBox(
                  height: 16,
                ),
                Text("HealthPal",style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 15,
                ),
                Text("Забыли пароль?",style: TextStyle(fontSize: 25),),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text("Введите свой адрес электронной почты, мы вышлем",style: TextStyle(fontSize: 15,color: Color.fromRGBO( 107, 114, 128, 1)),
                    textAlign: TextAlign.center, // Align text to center
                  ),
                ),
                SizedBox(
                  height: 29,
                ),

                Row(
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
                SizedBox(height: 30,),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(28, 42, 58, 1),
                      ),
                      foregroundColor:
                      MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(Size(350, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => NewPassword(),
                      ));
                    },
                    child: Text(
                      "Отправить код",
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
        ),
      ),


        );

  }
}
