import 'dart:convert';
import 'dart:io';

import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

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

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> _showCompletionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Поздравления"),
          content: Text("Ваша учетная запись успешно обновлена."),
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

  void _createAccount(BuildContext context) async {
    String? userId = await getUserId();
    if (userId == null) {
      // Handle case where userId is not available
      return;
    }
    String id = userId;
    String Name = nameController.text;
    String Email = emailController.text;
    String PhoneNumber = phoneController.text;
    String BirthDay = "2001-02-01";
    String Sex = "мужщина";


    var url = Uri.parse('http://192.168.50.225:5297/api/Users/UpdateProfileIfno?id=$userId');
    var body = jsonEncode({'id': id ,'UserName': Name, 'Email': Email, 'PhoneNumber': PhoneNumber, 'BirthDay': BirthDay, 'Sex': Sex });
    try {
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
      });
      print(body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        var userIdUp = responseData['id'].toString(); // Convert userId to String
        _showCompletionDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось ')),
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
                              backgroundImage:
                              _image != null ? FileImage(_image!) : null,
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
                              child: Image.asset('asset/images/pen_icon.png',
                                  width: 50, height: 50),
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
                          _createAccount(context);
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
