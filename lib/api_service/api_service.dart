import 'dart:async';
import 'dart:convert';
import 'package:bicard_diplomka_01_/models/appointmentsModel.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:bicard_diplomka_01_/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/calendar_provider.dart';

class ApiService {
  static const String IPAdres = "http://192.168.50.225:5297";
  static UserModel user = UserModel();

  Future<void> getUserInfo() async {
    final userId = await getUserId();
    final response = await http.get(
      Uri.parse(
          'http://192.168.50.225:5297/api/Users/GetProfileIfno?id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      user = UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile info');
    }
  }

  Future<GetTimesModels?> getDoctorAppointment(
      {required DateTime selectDate, required int id}) async {
    var url = '$IPAdres/api/Schedules/GetTimeSlots';
    var queryParams = {
      'currentDay': '${DateFormat("yyyy-MM-dd").format(selectDate)}T00:00:00Z',
      'doctorId': '$id',
    };
    var uri = Uri.parse(url).replace(queryParameters: queryParams);
    var response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'accept': '*/*',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      GetTimesModels? getTimesModels =
          GetTimesModels.fromJson(jsonDecode(response.body));
      return getTimesModels;
    }
    return null;
  }

  Future<void> sendUserId(String userId, BuildContext context) async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.50.225:5297/api/Users/GetProfileIfno?id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(userId);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel data = UserModel.fromJson(jsonDecode(response.body));
      print(response.body);

      print(data);
    } else {
      throw Exception('Failed to load profile info');
    }
  }

  Future<void> submitAppointment({
    required BuildContext context1,
    required BuildContext context2,
    required DateTime selectDate,
    required String time,
    required int id,
  }) async {
    final url = Uri.parse('$IPAdres/api/Appointments/Create');
    final headers = {'Content-Type': 'application/json'};

    // Получение userId из SharedPreferences
    final userId = await getUserId();
    final prefs = await SharedPreferences.getInstance();

    bool shouldSubmitAppointment = true;

    if (userId != null) {


      // Check if any profile data is missing
      if (user.userName == null || user.userName!.isEmpty ||
          user.email == null || user.email!.isEmpty ||
          user.phoneNumber == null || user.phoneNumber!.isEmpty ||
          user.age == null || user.age!.isEmpty) {
        // Display dialog if any profile data is missing
        showDialog(
          context: context1,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Profile Incomplete'),
              content: Text('Пополните свой профиль'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        shouldSubmitAppointment = false; // Установка флага в false, чтобы запрос не отправлялся
      }

      // Debugging statements to check values
      print('name: $user');
      if (shouldSubmitAppointment) {
        final body = jsonEncode({
          "name": user.userName,
          "email": user.email,
          "phoneNumber": user.phoneNumber,
          "age": user.age,
          'date': '${DateFormat("yyyy-MM-dd").format(selectDate)}T$time:00Z',
          "doctorId": id,
          "userId": int.parse(userId) // Преобразование userId в нужный формат
        });

        print(body);

        try {
          final response = await http.post(url, headers: headers, body: body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            _congratulations(context2);
            print('Appointment created successfully');
          } else {
            // Handle error
            print('Failed to create appointment: ${response.body}');
          }
        } catch (e) {
          print('Error: $e');
        }
      }
    } else {
      print('userId is null. Cannot submit appointment.');
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> _congratulations(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 25, 20, 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("asset/images/gotovo.png",
                      width: 140, height: 140),
                  const SizedBox(height: 15),
                  const Text(
                    "Поздравляю!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    child: Text(
                      "Ваша встреча с доктором Дэвидом Пателем назначена на "
                      "\n${context.read<CalendarProvider>().getDate()} ${context.read<CalendarProvider>().time?.time}.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(28, 42, 58, 1),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all(const Size(80, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Сделано",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<List<DoctorModel>> fetchDoctorsList() async {
    try {
      var url = '$IPAdres/api/Doctors/GetListOfDoctors';
      var uri = Uri.parse(url).replace(queryParameters: {'speciality': ''});
      ;
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Обработка успешного ответа, парсинг данных, если нужно
        final data = jsonDecode(response.body);
        print(response.body);
        return (data as List).map((doctor) {
          return DoctorModel.fromJson(doctor);
        }).toList();
      } else {
        throw 'Failed to fetch doctors list: ${response.statusCode}';
        // Обработка других кодов состояния, например, вывод сообщения об ошибке
      }
    } catch (error) {
      // Обработка сетевых ошибок
      throw 'Error fetching doctors list: $error';
    }
  }

  Future<List<DoctorModel>> HOSPITALIZATIONList() async {
    try {
      var url = '$IPAdres/api/Doctors/SearchBySpeciality';
      var uri = Uri.parse(url)
          .replace(queryParameters: {'speciality': 'HOSPITALIZATION'});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Обработка успешного ответа, парсинг данных
        final data = jsonDecode(response.body);
        print(data);
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

  Future<List<DoctorModel>> CARDIOLOGYList() async {
    try {
      var url = '$IPAdres/api/Doctors/SearchBySpeciality';
      var uri =
          Uri.parse(url).replace(queryParameters: {'speciality': 'Кардиолог'});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Обработка успешного ответа, парсинг данных
        final data = jsonDecode(response.body);
        print(data);
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

  Future<List<DoctorModel>> MICROSURGERYList() async {
    try {
      var url = '$IPAdres/api/Doctors/SearchBySpeciality';
      var uri = Uri.parse(url)
          .replace(queryParameters: {'speciality': 'MICROSURGERY'});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response);

        // Обработка успешного ответа, парсинг данных
        final data = jsonDecode(response.body);
        print(data);
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

  Future<List<DoctorModel>> SURGERYList() async {
    try {
      var url = '$IPAdres/api/Doctors/SearchBySpeciality';
      var uri =
          Uri.parse(url).replace(queryParameters: {'speciality': 'SURGERY'});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Обработка успешного ответа, парсинг данных
        final data = jsonDecode(response.body);
        print(data);
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

  Future<List<DoctorModel>> InfoDoctorsList(
      BuildContext context, int doctorId) async {
    try {
      var url = '$IPAdres/api/Doctors/GetDoctorById';
      var uri =
          Uri.parse(url).replace(queryParameters: {'speciality': '$doctorId'});
      ;
      final response = await http.get(uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Обработка успешного ответа, парсинг данных, если нужно
        final data = jsonDecode(response.body);
        print(data);
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

  Future<List<AppointmentsModel>> appointmentsModel() async {
    String? userId = await getUserId();

    try {
      var url = '$IPAdres/api/Appointments/GetAppointmentsByUserId?id=$userId';
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      print(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Обработка успешного ответа, парсинг данных
        final data = jsonDecode(response.body);
        print(data);
        return (data as List).map((doctor) {
          return AppointmentsModel.fromJson(doctor);
        }).toList();
      } else {
        throw 'Failed to fetch doctors list: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Error fetching doctors list: $error';
    }
  }
}
