import 'dart:convert';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/01_MainNavigator.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/02_registracia/sign_in.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/03_forget_password/forget_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

final TextEditingController _emailControllerIN = TextEditingController();
final TextEditingController _passwordControllerIN = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();

Future<void> _saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

void _signInAccount(BuildContext context) async {
  String email = _emailControllerIN.text;
  String password = _passwordControllerIN.text;

  var url = Uri.parse('http://192.168.159.243:5297/api/Users/login');
  var body = jsonEncode({'email': email, 'password': password});
  try {
    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      var userId = responseData['userId'].toString();
      print(responseData); // Convert userId to String

      // Save userId to SharedPreferences
      await _saveUserId(userId);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MainNavigator(),
      ));
      print(userId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('каттоо эсебиңиз табылган жок')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'каттоо эсебиңиз табылган жок.')),
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
                    Image.asset("asset/images/bicard.jpg",width: 150,height: 140,),

                    Text(
                      "Салам, кайтып келүүңүз менен!",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ден соолугунуз жайында деп үмүттөнөм.",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(107, 114, 128, 1)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _emailControllerIN,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "Электрондук почта"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _passwordControllerIN,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Сыр сөз"),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                          if (_formKey.currentState!.validate()) {
                            _signInAccount(context);
                          }
                        },
                        child: Text(
                          "Кирүү",
                          style: TextStyle(fontSize: 18),
                        )),

                    SizedBox(
                      height: 39,
                    ),
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
                            Text(" Google менен иштөөнү улантыңыз")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPassword()));
                        },
                        child: Text("Сырсөздү унутуп калдым?")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Алгач ирет катталуу "),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text("Каттоо"))
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
