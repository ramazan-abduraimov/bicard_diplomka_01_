
import 'dart:convert';

import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SmsAccaunt extends StatefulWidget {
  const SmsAccaunt({super.key});

  @override
  State<SmsAccaunt> createState() => _SmsAccauntState();
}

class _SmsAccauntState extends State<SmsAccaunt> {
  final TextEditingController _smsCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();


  void smsCodeSent(BuildContext context) async {
    String smsCodeController = _smsCodeController.text;


    var url = Uri.parse('http://192.168.50.225:5297/api/Users/register');
    print(url);
    var body = jsonEncode({'userName': smsCodeController,});
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('киргизилген тастыктама туура эмес')),
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
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SafeArea(
            top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: _smsCodeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Почтага жөнөтүлгөн кодду киргизиңиз",
                        ),
                      ),
                      SizedBox(height: 50,),
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
                            smsCodeSent(context);
                          }
                        },
                        child: Text(
                          "Жөнөтүү",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],),
                  ),
                ),
              )),
        ));
  }
}
