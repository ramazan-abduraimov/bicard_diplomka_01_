import 'dart:convert';

import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/01_MainNavigator.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/02_registracia/sign_up.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/03_forget_password/forget_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}
final TextEditingController _emailControllerIN = TextEditingController();

final TextEditingController  _passwordControllerIN= TextEditingController();

final GlobalKey<FormState> _formKey = GlobalKey();


void _signInAccount(BuildContext context) async {

  String email = _emailControllerIN.text;
  String password = _passwordControllerIN.text;

  var url = Uri.parse('http://192.168.50.226:5297/api/Users/login');
  print(url);
  var body = jsonEncode({ 'email': email, 'password': password});
  try {
    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201 )  {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MainNavigator(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ваша учетная запись не найдена')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Не удалось создать учетную запись. Пожалуйста, повторите попытку позже.')),
    );
  }
}
class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Form(
                key: _formKey,
                child: Column(
                              children: [
                Image.asset("asset/images/Vector.png"),
                SizedBox(
                  height: 15,
                ),
                Text("HealthPal",style: TextStyle(fontSize: 20),),
                                SizedBox(
                                  height: 15  ,
                                ),
                Text("Привет, с возвращением!",style: TextStyle(fontSize: 25),),
                                SizedBox(
                                  height: 10  ,
                                ),
                Text("Надеюсь, у тебя все хорошо.",style: TextStyle(fontSize: 15,color: Color.fromRGBO( 107, 114, 128, 1)),),
                                SizedBox(height: 25,),
                TextFormField(
                  controller: _emailControllerIN,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Электронной почты"),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  controller: _passwordControllerIN,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Пароль"),
                    obscureText: true,

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
                                      if(_formKey.currentState!.validate()) {
                                        _signInAccount(context);
                                      }
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (BuildContext context) => MainNavigator(),
                                      // ));
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(fontSize: 18),
                                    )),
                                SizedBox(height: 25,),
                Text("or"),
                                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.black,width: 0.5),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("asset/images/Google - Original.png"),
                        Text("   Продолжайте работать с Google")
                      ],
                    ),
                  ),
                ),
                                SizedBox(height: 25,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(color: Colors.black,width: 0.5),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("asset/images/_Facebook.png"),
                                        Text("    Продолжайте с Facebook")
                                      ],
                                    ),
                                  ),
                                ),
                SizedBox(height: 15,),
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
                                  builder: (context) =>  SignUp()));
                        },
                        child: Text("Pегистрация"))
                  ],
                )
                              ],
                            ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
