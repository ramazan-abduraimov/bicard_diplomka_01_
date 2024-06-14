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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
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
                          onPressed: () {
                            // Example of using _nameController.text
                            String searchTerm = _nameController.text;
                            // Call your search function or method here with searchTerm
                            searchDoctorsList(searchTerm);
                            SearchDoctor();
                          },
                          icon: Icon(Icons.search, size: 40),
                        ),
                      ],
                    ),
                  ),SizedBox(height: 25,),
                  SearchDoctor(),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
Future<List<DoctorModel>> searchDoctorsList([String? searchTerm]) async {
  try {
    var url = 'http://192.168.201.14:5297/api/Doctors/SearchByName?name=$searchTerm';
    print(url);

    var uri = Uri.parse(url);
    ;
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // Обработка успешного ответа, парсинг данных, если нужно
      final data = jsonDecode(response.body);
      return (data as List).map((doctor) {
        return DoctorModel.fromJson(doctor);
      }).toList();
      // Делайте что-то с данными
    } else {
      throw 'Failed to fetch doctors list: ${response.statusCode}';
      // Обработка других кодов состояния, например, вывод сообщения об ошибке
    }
  } catch (error) {
    // Обработка сетевых ошибок
    throw 'Error fetching doctors list: $error';
  }
}



class SearchDoctor extends StatelessWidget {
  const SearchDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchDoctorsList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DoctorModel> allDoctorsList = snapshot.data ?? [];
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DoctorModel doctor = allDoctorsList[index];
                return Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                          // Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => DoctorDetailsScreen(
                          //           doctorInfo: doctorinfo,
                          //           reviews: reviews,
                          //         ),
                          //       ));
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
                                  child: Image.network(
                                    "${ApiService.IPAdres}/TempFileStorage/${doctor.pathToPhoto}",
                                    fit: BoxFit.cover,
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