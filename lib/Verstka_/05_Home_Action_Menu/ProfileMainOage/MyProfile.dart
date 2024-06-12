import 'dart:io';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/ProfileMainOage/ProfilePage.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/02_registracia/FillYourProfile.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_service/api_service.dart';

class MyInfoProfilePage extends StatefulWidget {
  final UserModel profileData;

  const MyInfoProfilePage({super.key, required this.profileData});

  @override
  State<MyInfoProfilePage> createState() => _MyInfoProfilePageState();
}

class _MyInfoProfilePageState extends State<MyInfoProfilePage> {
  Future<void> _clearProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('birthDay');
    await prefs.remove('gender');
  }

  @override
  Widget build(BuildContext context) {
    final profileData = widget.profileData;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "My Info Profile",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          "${ApiService.IPAdres}/TempFileStorage/${widget.profileData.photoPath}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 300,
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Имя и Фамилия",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${profileData.userName}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Электронный Почты",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${profileData.email}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Телефон номер",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${profileData.phoneNumber}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Возраст",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${profileData.age}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Пол",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${profileData.sex}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                      minimumSize: MaterialStateProperty.all(Size(380, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: ()  {
                      // await _clearProfileData(); // Clear specific profile data
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FillYourProfile()));
                    },
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18),
                    ),
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
