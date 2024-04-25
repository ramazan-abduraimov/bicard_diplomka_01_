import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/02_sign_up/FillYourProfile.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';

class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _createAccount(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    print(name);
    var url = Uri.parse('http://192.168.159.243:5297/api/Users/register');
    print(url);
    var body = jsonEncode({'userName': name, 'email': email, 'password': password});
    try {
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => FillYourProfile(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create account')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account. Please try again later.')),
      );
    }
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("asset/images/Vector.png",),
                  SizedBox(height: 15,),
                  Text("HealthPal",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 15,),
                  Text("Создать аккаунт",style: TextStyle(fontSize: 25),),
                  SizedBox(height: 10,),
                  Text("Мы здесь, чтобы помочь вам!",style: TextStyle(fontSize: 15,color: Color.fromRGBO( 107, 114, 128, 1)),),
                  SizedBox(height: 25,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            prefixIcon: Icon(Icons.person),
                            labelText: "Ваше имя",
                          ),
                        ),
                        SizedBox(height: 25,),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Электронной почты",
                          ),
                        ),
                        SizedBox(height: 25,),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Пароль",
                          ),
                          obscureText: true,
                        ),
                      ],
                    ),
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
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _createAccount(context);
                      }
                    },
                    child: Text(
                      "Создать аккаунт",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("У вас есть учетная запись? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                        child: Text("Bойти"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
