
import 'package:bicard_diplomka_01_/Verstka_/proba.dart';
import 'package:flutter/material.dart';

class Hospitalization extends StatelessWidget {
  const Hospitalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Все Доктора ")),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(children: [
                TextFormField(
                    decoration: const InputDecoration(
                        filled: true, // Fill the background with color
                        fillColor: Color.fromRGBO(243, 244, 246, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(243, 244, 246, 1),
                          ), // Border color
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(156, 163, 175, 1),
                        ),
                        labelText: "Search doctor...",
                        labelStyle:
                        TextStyle(color: Color.fromRGBO(156, 163, 175, 1)))),
                GestureDetector(
                  onTap: (){

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>DoctorDetailsScreen(doctorInfo: doctorinfo, reviews: reviews, ),));
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 100, // Adjust the width and height as needed to make it square
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white, width: 2.0), // Border details
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset("asset/images/DoctorImage.png"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             "Dr. David Patel",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text("Cardiologist"),
                            Text('Cardiology Center , USA'),
                            Row(
                              children: [
                                Icon(Icons.star),
                                Text('4.8 (1872)'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {

                        }, // Add favorite functionality
                      ),
                    ],
                  ),
                ),

                  ],),
            ),
          ),
        ),
      ),);
  }
}
