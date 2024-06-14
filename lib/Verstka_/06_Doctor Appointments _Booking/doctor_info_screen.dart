import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Book_Appointment.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:bicard_diplomka_01_/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorInfoScreen extends StatefulWidget {
  final DoctorModel doctorModel;

  const DoctorInfoScreen({
    super.key,
    required this.doctorModel,
  });

  @override
  State<DoctorInfoScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorInfoScreen> {
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
      appBar: AppBar(
        title: Text("Doctor Details"),
        // Add back button and heart icon as needed
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: SingleChildScrollView(

              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
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
                                  "${ApiService.IPAdres}/TempFileStorage/${widget.doctorModel.pathToPhoto}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 18.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(widget.doctorModel.name ?? "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                                SizedBox(height: 15),
                                Text(
                                    widget.doctorModel.speciality ?? "speciality",
                                    style: TextStyle(fontSize: 16.0)),
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
                            Text('2,00+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              'пациенты',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                                radius: 30,
                                child: Icon(Icons.workspace_premium_sharp)),
                            Text("3-жыл",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              'опыт',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                                radius: 30,
                                child: Icon(Icons.star)),
                            Text('4',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              'rating',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                                radius: 30,
                                child: Icon(Icons.chat)),
                            Text('100+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              'reviews',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20.0),

                    // About Me Section
                    Text('Обо мне ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    SizedBox(height: 8.0),
                    Text(widget.doctorModel.experience ?? "Бош"),
                    // Add "View More" functionality if needed

                    SizedBox(height: 20.0),

                    // Working Time Section
                    Text('Рабочее время ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    SizedBox(height: 8.0),
                    Text(
                        "Дүйшөмбү-Жума,   09:00 - 18:00\nИшемби,                  09:00 - 13:00"),

                    SizedBox(height: 20.0),

                    // Reviews Section
                    Text('Обзоры',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    SizedBox(height: 8.0),
                    // Display reviews (implement as described above)
                    Reviews(),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DateTimePicker(),
                ));
                context.read<CalendarProvider>().id = widget.doctorModel.id;
              },
              child: Text(
                "Запишитесь на прием ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().CARDIOLOGYList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DoctorModel> allDoctorsList = snapshot.data ?? [];
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DoctorModel doctor = allDoctorsList[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  width: 380,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 4),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: 380,
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // Adjust the border radius as needed
                              child:   Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${ApiService.IPAdres}/TempFileStorage/${doctor.pathToPhoto}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 18.0),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctor.name ?? "Бош",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0)),
                                  Text(doctor.speciality ?? " Bosh",
                                      style: TextStyle(fontSize: 16.0)),
                                  Text(doctor.phoneNumber ?? "bosh",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 35,
                          ),
                        )),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: allDoctorsList.length,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return SizedBox();
        });
  }
}
