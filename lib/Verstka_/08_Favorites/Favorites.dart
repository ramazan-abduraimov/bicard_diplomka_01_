
import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Doctor_Details.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text("Favorites ")),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(children: [
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
