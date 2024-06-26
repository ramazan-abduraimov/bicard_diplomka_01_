
import 'dart:convert';

import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/Doctors_Appointment.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/HomePage.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/MapPage.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/ProfileMainOage/ProfilePage.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';




class MainNavigator extends StatefulWidget {

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  var selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getUserInfo();
  }

  @override
  Widget build(BuildContext context  ) {
    List<Widget> screens = [
      HomePage(),
      MapPage(),
      DoctorsAppointment(),
      ProfilePage(),
    ];
    void onItemTap(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      body: Container(
        child: screens[selectedIndex],
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/homeNotifigation.png",
              width: 23.36,
              height: 23.6,
              color: Colors.grey,
            ),
            label: "Үй",

          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/Search by Location.png",
              width: 20,
              height: 24.5,
            ),
            label: "Карта",
          ),

          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/Appointment.png",
              width: 23.35,
              height: 23.33,
            ),
            label: "Катталуу",
          ),
          BottomNavigationBarItem(

            icon: Image.asset(
              "asset/images/Profile.png",
              width: 21,
              height: 21,
            ),
            label: "Профиль",
          ),
        ],
        selectedItemColor: Colors.black, // Set the selected item color
        unselectedItemColor: Colors.black, // Set the unselected item color
        selectedLabelStyle: TextStyle(color: Colors.black), // Set the selected label text color
        unselectedLabelStyle: TextStyle(color: Colors.black),
      ),

    );
  }

}