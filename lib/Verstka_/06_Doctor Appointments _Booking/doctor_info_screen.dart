import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:bicard_diplomka_01_/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Book_Appointment.dart';

class DoctorInfoScreen extends StatefulWidget {
  final DoctorModel doctorModel;

  const DoctorInfoScreen({super.key, required this.doctorModel});

  @override
  State<DoctorInfoScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details"),
        // Add back button and heart icon as needed
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Information Section
            Container(
              width: 380,
              height: 120,
              child: Material(
                elevation: 5.0,
                // Adjust the elevation as needed
                shadowColor: Colors.grey,
                // Adjust the shadow color as needed
                borderRadius: BorderRadius.circular(10),
                // Adjust the border radius as needed
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Adjust the border radius as needed
                      child: Container(
                        width: 100,
                        // Adjust the width and height as needed to make it square
                        height: 100,
                        child: Image.network(
                            "${ApiService.IPAdres}/TempFileStorage/${widget.doctorModel.pathToPhoto}",fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(width: 18.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(widget.doctorModel.name ?? "Бош",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                        Text(widget.doctorModel.speciality ?? "Бош",
                            style: TextStyle(fontSize: 16.0)),
                        Text(widget.doctorModel.address ?? "Бош",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                        radius: 30,
                        child: Icon(Icons.people)),
                    Text('2,000+',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'пациенты',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                        radius: 30,
                        child: Icon(Icons.workspace_premium_sharp)),
                    Text(widget.doctorModel.experience ?? "1",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'опыт',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                        radius: 30,
                        child: Icon(Icons.star)),
                    Text('',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'rating',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                        radius: 30,
                        child: Icon(Icons.chat)),
                    Text('',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'reviews',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.0),

            // About Me Section
            Text('Обо мне ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text(widget.doctorModel.bio ?? "Бош"),
            // Add "View More" functionality if needed

            SizedBox(height: 20.0),

            // Working Time Section
            Text('Рабочее время ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text(""),

            SizedBox(height: 20.0),

            // Reviews Section
            Text('Обзоры',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            // Display reviews (implement as described above)

            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(28, 42, 58, 1),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(Size(380, 50)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              onPressed: () {
                context.read<CalendarProvider>().id = widget.doctorModel.id;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DateTimePicker()));
              },
              child: Text(
                "Запишитесь на прием ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
