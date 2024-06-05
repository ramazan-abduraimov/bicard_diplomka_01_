import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class FillYourProfile extends StatefulWidget {
  const FillYourProfile({Key? key}) : super(key: key);

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
  String date = '';
  String gender = '';
  File? _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _showOptionsDialog() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Выберите фото'),
              onTap: () {
                Navigator.pop(context); // Close the modal bottom sheet
                getImage(); // Open the image picker
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Удалить фото'),
              onTap: () {
                setState(() {
                  _image = null;
                });
                Navigator.pop(context); // Close the modal bottom sheet
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateTextField(String label, String value) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        prefixIcon: Icon(Icons.cake_outlined),
        labelText: label,
      ),
      controller: TextEditingController(text: value),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        date = DateFormat('yyyy-MM-dd').format(pickedDate); // Update the date variable
      });
    }
  }

  Widget _buildGenderDropdown(String label, String value) {
    if (value != "Мужчина" && value != "Женщина") {
      value = "Мужчина";
    }

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        prefixIcon: Icon(Icons.accessibility_sharp),
      ),
      value: value,
      onChanged: (newValue) {
        setState(() {
          gender = newValue!;
        });
      },
      items: <String>['Мужчина', 'Женщина'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }


  Future<void> _saveProfileData(BuildContext context) async {
    // Prepare data to send
    Map<String, dynamic> profileData = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text.toString(),
      'birthday': date.toString(),
      'gender': gender,
    };
    print(profileData);

    // Bypass SSL verification (for development purposes only)
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    final response = await httpClient.put(
      Uri.parse('https://192.168.50.226:5297/api/Users/UpdateProfileIfno?id=2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      _showCompletionDialog();
    } else {
      print('Failed to save profile data: ${response.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to save profile data."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _showCompletionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Поздравления"),
          content: Text("Ваша учетная запись готова к использованию."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill Your Profile",
          style: TextStyle(color: Color.fromARGB(153, 0, 0, 0)),
        ),
      ),
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
                    Container(
                      height: 170,
                      width: 170,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: getImage,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: _image != null ? FileImage(_image!) : null,
                              child: _image == null
                                  ? Icon(
                                Icons.person,
                                size: 80,
                              )
                                  : null,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            right: 0,
                            child: TextButton(
                              onPressed: _showOptionsDialog,
                              child: Image.asset('asset/images/pen_icon.png', width: 50, height: 50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.person),
                        labelText: "Имя и Фамилия",
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "Электронной почты",
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.numbers_outlined),
                        labelText: "Телефон номер",
                      ),
                    ),
                    SizedBox(height: 25),
                    _buildDateTextField("День рождения", date),
                    SizedBox(height: 25),
                    _buildGenderDropdown("Gender", gender),
                    SizedBox(height: 55),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(28, 42, 58, 1),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(Size(350, 50)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveProfileData(context);
                        }
                      },
                      child: Text(
                        "Сохранить",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 50),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    home: FillYourProfile(),
  ));
}
