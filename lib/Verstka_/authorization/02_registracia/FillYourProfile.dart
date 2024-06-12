import 'dart:convert';
import 'dart:io';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/01_MainNavigator.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/ProfileMainOage/MyProfile.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadProfileData();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });

  }
  String date = '';
  String gender = '';
  File? _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _clearProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('birthDay');
    await prefs.remove('gender');
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      date = prefs.getString('birthDay') ?? '';
      gender = prefs.getString('gender') ?? 'Мужчина';
    });
  }

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
        date = DateFormat('yyyy-MM-dd')
            .format(pickedDate); // Update the date variable
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
              onPressed: ()  {
                sendUserId(userId!);
              },

              // Navigator.of(context).pop();

              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendUserId(String userId) async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.50.225:5297/api/Users/GetProfileIfno?id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(userId);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel data = UserModel.fromJson(jsonDecode(response.body));


      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MainNavigator(),
      ));
      print(data);
    } else {
      throw Exception('Failed to load profile info');
    }
  }

  void _createAccount(BuildContext context) async {
    String? userId = await getUserId();
    if (userId == null) {
      // Handle case where userId is not available
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not available')),
      );
      return;
    }

    String name = nameController.text;
    String email = emailController.text;
    String phoneNumber = phoneController.text;
    String birthDay = date; // Ensure date is correctly formatted if needed
    String sex = gender;

    var url = Uri.parse(
        'http://192.168.50.225:5297/api/Users/UpdateProfileIfno?id=$userId');

    var request = http.MultipartRequest('POST', url)
      ..fields['UserName'] = name
      ..fields['Email'] = email
      ..fields['PhoneNumber'] = phoneNumber
      ..fields['BirthDay'] = birthDay
      ..fields['Sex'] = sex;

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _saveProfileData(name, email, phoneNumber, birthDay, sex);
        _showCompletionDialog();

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
        _clearProfileData();
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to create account. Please try again later.')),
      );
    }
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return date; // Return the original date string if parsing fails
    }
  }

  Future<void> _saveProfileData(String name, String email, String phone,
      String birthDay, String gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('birthDay', birthDay);
    await prefs.setString('gender', gender);
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
