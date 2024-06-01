import 'dart:convert';

import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Cardiology.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Hospitalization.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Microsurgery.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Surgery.dart';
import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Doctor_Details.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class DoctorDoc {
  final String name;
  final String specialization;
  final String clinic;

  DoctorDoc({
    required this.name,
    required this.specialization,
    required this.clinic,
  });
}

final doctorsinfo = DoctorDoc(
  name: 'Дэвид Патель',
  specialization: 'Кардиолог',
  clinic: 'Золотой кардиологический центр',
);

class _HomePageState extends State<HomePage> {
  double FotoSize = 85;

  void _navigateToDetailPage(BuildContext context, int index) {
    // Depending on the index, navigate to different detail pages
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => InfoCardiology()));
        break;
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => InfoHospitolization()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => InfoMicrosurgery()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => InfoSurgery()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Bicard",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                        child: Icon(
                          Icons.notifications_active_rounded,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        // Fill the background with color
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
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(156, 163, 175, 1)))),
                SizedBox(
                  height: 15,
                ),
                CarouselSlider.builder(
                  itemCount: 4,
                  options: CarouselOptions(
                    height: 220.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    onPageChanged: (index, reason) {},
                    viewportFraction: 1,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    List<String> imagePaths = [
                      "asset/images/HospitalizationCategory.png",
                      "asset/images/CardiologyCategory.jpg",
                      "asset/images/MicrosurgeryCategory.jpg",
                      "asset/images/SurgeryCategory.jpg",
                    ];

                    return GestureDetector(
                      onTap: () {
                        _navigateToDetailPage(
                            context, index); // Navigate to detail page
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Image.asset(
                              imagePaths[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 20,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text("4.8"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Категория врачей",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ButtonList(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonList extends StatefulWidget {
  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  int _selectedIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildButton(0, "All"),
              SizedBox(width: 15),
              _buildButton(1, "HOSPITALIZATION"),
              SizedBox(width: 15),
              _buildButton(2, "CARDIOLOGY"),
              SizedBox(width: 15),
              _buildButton(3, "MICROSURGERY"),
              SizedBox(width: 15),
              _buildButton(4, "SURGERY"),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _selectedIndex == 0
            ? All()
            : _selectedIndex == 1
                ? HOSPITALIZATION()
                : _selectedIndex == 2
                    ? CARDIOLOGY()
                    : _selectedIndex == 3
                        ? MICROSURGERY()
                        : _selectedIndex == 4
                            ? SURGERY()
                            : SizedBox(),
      ],
    );
  }

  Widget _buildButton(int index, String text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => _onButtonPressed(index),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black54),
            color: _selectedIndex == index
                ? Color.fromRGBO(28, 42, 58, 1)
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  color: _selectedIndex == index ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class All extends StatelessWidget {
  const All({super.key});

  Future<void> sendRequest(BuildContext context, int doctorId) async {
    final url = 'http://192.168.50.226:5297/api/Doctors/GetDoctorById?doctorId=$doctorId'; // Adjust URL construction based on your API
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response data (adjust based on your actual response structure)
        var responseData = jsonDecode(response.body);
        var doctorinfo = responseData['doctorinfo'];
        var reviews = responseData['reviews'];

        // Navigate to the DoctorDetailsScreen and pass necessary data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(
              doctorInfo: doctorinfo,
              reviews: reviews,
            ),
          ),
        );
        print('Request successful');
      } else {
        // Handle other status codes (e.g., display an error message)
        throw Exception('Failed to load doctor details');
      }
    } catch (e) {
      // Handle exceptions thrown during the request
      print('Exception during request: $e');
      // Display an error dialog or message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch doctor details. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().fetchDoctorsList(),
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
                      GestureDetector(
                        onTap: () {
                if (doctor.id != null) {
                sendRequest(context,doctor.id!); // Send request with doctor.id
                } else {
                // Handle the case when doctor.id is null
                print('Doctor ID is null');
                }
                },

                        child: Container(
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
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      "http://192.168.50.226:5297/TempFileStorage/${doctor.pathToPhoto}" ??
                                          "asset/images/DoctorImage.png"),
                                ),
                              ),
                              SizedBox(width: 18.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            fontSize: 14.0, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                   // Send request with doctor.id
                                },
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.favorite_outline,
                                    size: 35,
                                  ),
                                )),
                            Text(doctor.id.toString() ?? "ertgr"),
                          ],
                        ),
                      ),
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


class HOSPITALIZATION extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().HOSPITALIZATIONList(),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsScreen(
                                  doctorInfo: doctorinfo,
                                  reviews: reviews,
                                ),
                              ));
                        },
                        child: Container(
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
                                child: Container(
                                  width: 100,
                                  // Adjust the width and height as needed to make it square
                                  height: 100,
                                  child: Image.network("http://192.168.50.226:5297/TempFileStorage/${doctor.pathToPhoto}" ??
                                      "asset/images/DoctorImage.png"),
                                ),
                              ),
                              SizedBox(width: 18.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            fontSize: 14.0, color: Colors.grey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:  GestureDetector(
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

class CARDIOLOGY extends StatelessWidget {
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsScreen(
                                  doctorInfo: doctorinfo,
                                  reviews: reviews,
                                ),
                              ));
                        },
                        child: Container(
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
                                child: Container(
                                  width: 100,
                                  // Adjust the width and height as needed to make it square
                                  height: 100,
                                  child: Image.network("http://192.168.50.226:5297/TempFileStorage/${doctor.pathToPhoto}" ??
                                      "asset/images/DoctorImage.png"),
                                ),
                              ),
                              SizedBox(width: 18.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            fontSize: 14.0, color: Colors.grey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:  GestureDetector(
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
        });  }
}

class MICROSURGERY extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().MICROSURGERYList(),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsScreen(
                                  doctorInfo: doctorinfo,
                                  reviews: reviews,
                                ),
                              ));
                        },
                        child: Container(
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
                                child: Container(
                                  width: 100,
                                  // Adjust the width and height as needed to make it square
                                  height: 100,
                                  child: Image.network("http://192.168.50.226:5297/TempFileStorage/${doctor.pathToPhoto}" ??
                                      "asset/images/DoctorImage.png"),
                                ),
                              ),
                              SizedBox(width: 18.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            fontSize: 14.0, color: Colors.grey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:  GestureDetector(
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
        });  }
}

class SURGERY extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().SURGERYList(),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsScreen(
                                  doctorInfo: doctorinfo,
                                  reviews: reviews,
                                ),
                              ));
                        },
                        child: Container(
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
                                child: Container(
                                  width: 100,
                                  // Adjust the width and height as needed to make it square
                                  height: 100,
                                  child: Image.network("http://192.168.50.226:5297/TempFileStorage/${doctor.pathToPhoto}" ??
                                      "asset/images/DoctorImage.png"),
                                ),
                              ),
                              SizedBox(width: 18.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            fontSize: 14.0, color: Colors.grey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:  GestureDetector(
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
        });  }
}
