import 'dart:io';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/ProfileMainOage/MyProfile.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
   final UserModel treaData;

   const ProfilePage({super.key, required  this.treaData});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    sendUserId2;
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });

  }

  Future<void> sendUserId2(String userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.50.225:5297/api/Users/GetProfileIfno?id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(userId);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel data = UserModel.fromJson(jsonDecode(response.body));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage(treaData: data),
      ));
      print(response.body);

    } else {
      throw Exception('Failed to load profile info');
    }
  }



  Future<void> sendUserId(String userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.50.225:5297/api/Users/GetProfileIfno?id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(userId);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel data = UserModel.fromJson(jsonDecode(response.body));

      print(response.body);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MyInfoProfilePage(profileData: data),
      ));
      print(data);
    } else {
      throw Exception('Failed to load profile info');
    }
  }

  @override
  Widget build(BuildContext context) {
    final treaData = widget.treaData;
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
                      "Profile",
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
                            "${ApiService.IPAdres}/TempFileStorage/${widget.treaData.photoPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      treaData.userName ?? "name",
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      treaData.phoneNumber ??
                      "phoneNumber",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listItemWidget(
                            'My Info Profile', Icons.person_add_alt_1_rounded,
                                () async {
                              if (userId != null) {
                                await sendUserId(userId!);
                              }
                            }),
                        listItemWidget('Settings', Icons.settings, () {
                          print('Settings button tapped');
                        }),
                        listItemWidget('Terms and Conditions', Icons.security_rounded, () {
                          print('Terms and Conditions button tapped');
                        }),
                        listItemWidget('Log Out', Icons.logout, () {
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
