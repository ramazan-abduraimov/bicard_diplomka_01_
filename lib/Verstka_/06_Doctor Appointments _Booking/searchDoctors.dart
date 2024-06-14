import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/doctor_info_screen.dart';
import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchdoctors extends StatefulWidget {
  @override
  State<Searchdoctors> createState() => _SearchdoctorsState();
}

class _SearchdoctorsState extends State<Searchdoctors> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<List<DoctorModel>>? _futureDoctors;

  Future<List<DoctorModel>> searchDoctorsList(String name) async {
    try {
      var url = 'http://192.168.50.225:5297/api/Doctors/SearchByName?name=$name';
      print(url);

      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data as List).map((doctor) {
          return DoctorModel.fromJson(doctor);
        }).toList();
      } else {
        throw 'Failed to fetch doctors list: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Error fetching doctors list: $error';
    }
  }

  void _search() {
    setState(() {
      _futureDoctors = searchDoctorsList(_nameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _search();
        },
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                labelText: "Издоо",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          onPressed: _search,
                          icon: Icon(Icons.search, size: 40),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  _futureDoctors == null
                      ? Container()
                      : SearchDoctor(futureDoctors: _futureDoctors!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchDoctor extends StatelessWidget {
  final Future<List<DoctorModel>> futureDoctors;

  const SearchDoctor({required this.futureDoctors, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DoctorModel>>(
        future: futureDoctors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<DoctorModel> allDoctorsList = snapshot.data ?? [];
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DoctorModel doctor = allDoctorsList[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  width: 380,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
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
                              builder: (context) => DoctorInfoScreen(
                                  doctorModel: doctor),
                            ),
                          );
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
                                    "${ApiService.IPAdres}/TempFileStorage/${doctor.pathToPhoto}",
                                    fit: BoxFit.cover,
                                  ),
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
                                            fontSize: 14.0,
                                            color: Colors.grey)),
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
                              onTap: () {},
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.favorite_outline,
                                  size: 35,
                                ),
                              ),
                            ),
                            Text("${doctor.id}"),
                          ],
                        ),
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
          } else {
            return SizedBox();
          }
        });
  }
}
