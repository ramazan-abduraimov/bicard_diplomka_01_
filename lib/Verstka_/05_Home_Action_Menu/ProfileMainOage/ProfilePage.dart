import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/ProfileMainOage/MyProfile.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  children: [
                    Text(
                      "Профиль",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            "${ApiService.IPAdres}/TempFileStorage/${ApiService.user.photoPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ApiService.user.userName ?? "name",
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      ApiService.user.phoneNumber ?? "phoneNumber",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listItemWidget('Менин Маалымат Профилим',
                            Icons.person_add_alt_1_rounded, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyInfoProfilePage(),
                            ),
                          );
                        }),
                        listItemWidget('Орнотуулар', Icons.settings, () {
                          print('Орнотуулар ');
                        }),
                        listItemWidget('Шарттары ', Icons.security_rounded, () {
                          print('Terms and Conditions button tapped');
                        }),
                        listItemWidget('Чыгуу', Icons.logout, () {
                          print('Log Out button tapped');
                        }),
                      ],
                    ),
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

Widget listItemWidget(String text, IconData? icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon),
          SizedBox(width: 8.0),
          Text(text),
          Spacer(),
          Icon(Icons.chevron_right),
        ],
      ),
    ),
  );
}
