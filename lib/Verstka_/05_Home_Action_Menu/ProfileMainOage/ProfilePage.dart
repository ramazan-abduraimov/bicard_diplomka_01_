import 'dart:io';
import 'package:bicard_diplomka_01_/Verstka_/05_Home_Action_Menu/ProfileMainOage/MyProfile.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/02_registracia/FillYourProfile.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

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
              title: Text('Choose photo'),
              onTap: () {
                Navigator.pop(context); // Close the modal bottom sheet
                getImage(); // Open the image picker
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Remove photo'),
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
                      "Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // Profile section (placeholder for image)
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
                                  ? Image.asset(
                                      "asset/images/ProfileVector.png")
                                  : null,
                            ),
                          ),
                          Positioned(
                            top: 108,
                            right: 0,
                            child: TextButton(
                              onPressed: _showOptionsDialog,
                              child: Image.asset(
                                'asset/images/pen_icon.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Daniel Martinez",
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      "0 996 990 557 612",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // List items
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listItemWidget(
                            'My Info Profile', Icons.person_add_alt_1_rounded,
                            () {
                          // ApiService().sendUserId(UserId)
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (BuildContext context) =>
                          //       MyInfoProfilePage(userModel: ,),
                          // ));
                        }),
                        listItemWidget('Settings', Icons.settings, () {
                          // Handle Settings button tap
                          print('Settings button tapped');
                        }),
                        listItemWidget(
                            'Terms and Conditions', Icons.security_rounded, () {
                          // Handle Terms and Conditions button tap
                          print('Terms and Conditions button tapped');
                        }),
                        listItemWidget('Log Out', Icons.logout, () {
                          // Handle Log Out button tap
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

// Widget to represent each list item
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
          Icon(Icons.chevron_right), // Chevron for navigation
        ],
      ),
    ),
  );
}
