import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class MyHomePage12 extends StatefulWidget {
  @override
  State<MyHomePage12> createState() => _MyHomePage12State();
}

class _MyHomePage12State extends State<MyHomePage12> {
   File? _image;


  Future<void> getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

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
                    Text("Профиль",style: TextStyle(fontSize: 20),),
                    SizedBox(height: 25,),
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
                              backgroundImage: _image != null ? FileImage(_image!) : null,
                              child: _image == null
                                  ? Image.asset("asset/images/Vector.png")
                                  : null,
                            ),
                          ),
                          Positioned(
                            top: 108,
                            right: 0,
                            child: TextButton(
                              onPressed: _showOptionsDialog,
                              child: Image.asset('asset/images/pen_icon.png', width: 50, height: 50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Edit profile button

                    // List items
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listItemWidget('Favorite', Icons.favorite),
                        listItemWidget('Notifications', Icons.notifications),
                        listItemWidget('Settings', Icons.settings),
                        listItemWidget('Help and Support', Icons.help),
                        listItemWidget('Terms and Conditions', null), // No icon for terms
                        listItemWidget('Log Out', Icons.logout),
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
Widget listItemWidget(String text, IconData? icon) {

  return Row(
    children: [
      if (icon != null)
        Icon(icon),
      SizedBox(width: 8.0),
      Text(text),
      Spacer(),
      Icon(Icons.chevron_right), // Chevron for navigation
    ],
  );
}