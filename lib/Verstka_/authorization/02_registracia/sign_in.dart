import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _clearProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('birthDay');
    await prefs.remove('gender');
  }

  void _createAccount(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    var url = Uri.parse('http://192.168.50.225:5297/api/Users/register');
    print(url);
    var body = jsonEncode({'userName': name, 'email': email, 'password': password});
    try {
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
      });
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        var userIdUp = responseData['id'].toString(); // Convert userId to String
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ));
        _clearProfileData();

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось создать учетную запись')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось создать учетную запись. Пожалуйста, повторите попытку позже.')),
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
                  Image.asset("asset/images/bicard.jpg",width: 150,height: 140,),
                  Text("Каттоо эсебин түзүү", style: TextStyle(fontSize: 25),),
                  SizedBox(height: 10,),
                  Text("Биз сизге жардам берүү үчүн келдик!", style: TextStyle(fontSize: 15, color: Color.fromRGBO(107, 114, 128, 1)),),
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
                            labelText: "Сиздин атыңыз",
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
                            labelText: "Электрондук почта",
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
                            labelText: "Сыр сөз",
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
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(Size(350, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createAccount(context);
                      }
                    },
                    child: Text(
                      "Каттоо эсебин түзүү",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  SizedBox(height: 40,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("asset/images/Google - Original.png"),
                          Text("  Google менен иштөөнү улантыңыз")
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Сиз каттодон өткөнсузбу? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                        child: Text("Кирүү"),
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

class UserIdScreen extends StatefulWidget {
  final String userId;

  UserIdScreen({required this.userId});

  @override
  State<UserIdScreen> createState() => _UserIdScreenState();
}

class _UserIdScreenState extends State<UserIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'User ID: ${widget.userId}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
