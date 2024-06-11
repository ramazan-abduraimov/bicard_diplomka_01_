import 'dart:async';
import 'dart:convert';

import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Doctor_Details.dart';
import 'package:bicard_diplomka_01_/models/appointmentsModel.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String IPAdres = "http://192.168.250.243:5297";



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

  Future<void> submitAppointment({
    required DateTime selectDate,
    required String time,
    required int id,
  }) async {
    final url = Uri.parse('$IPAdres/api/Appointments/Create');
    final headers = {'Content-Type': 'application/json'};

    // Получение userId из SharedPreferences
    final userId = await getUserId();
    final prefs = await SharedPreferences.getInstance();

    if (userId != null) {
      // Получение данных профиля из SharedPreferences
      final name = prefs.getString('name') ?? '';
      final email = prefs.getString('email') ?? '';
      final phoneNumber = prefs.getString('phone') ?? '';
      final birthDay = prefs.getString('birthDay') ?? '';

      // Debugging statements to check values
      print('name: $name');
      print('email: $email');
      print('phoneNumber: $phoneNumber');
      print('birthDay: $birthDay');
      print('userId: $userId');

      final body = jsonEncode({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "age": birthDay,
        'date': '${DateFormat("yyyy-MM-dd").format(selectDate)}T$time:00Z',
        "doctorId": id,
        "userId": int.parse(userId) // Преобразование userId в нужный формат
      });

      print(body);

      try {
        final response = await http.post(url, headers: headers, body: body);
        if (response.statusCode == 200) {
          // Handle success
          print('Appointment created successfully');
        } else {
          // Handle error
          print('Failed to create appointment: ${response.body}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('userId is null. Cannot submit appointment.');
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
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

  Future<List<DoctorModel>> HOSPITALIZATIONList() async {
    try {
      var url = 'http://192.168.50.226:5297/api/Doctors/SearchBySpeciality';
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
      var url = 'http://192.168.50.226:5297/api/Doctors/SearchBySpeciality';
      var uri =
          Uri.parse(url).replace(queryParameters: {'speciality': 'CARDIOLOGY'});
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
      var url = 'http://192.168.50.226:5297/api/Doctors/SearchBySpeciality';
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
      var url = 'http://192.168.50.226:5297/api/Doctors/SearchBySpeciality';
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
      var url = 'http://192.168.50.226:5297/api/Doctors/GetDoctorById';
      var uri =
          Uri.parse(url).replace(queryParameters: {'speciality': '$doctorId'});
      ;
      final response = await http.get(uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(
                doctorInfo: doctorinfo,
                reviews: reviews,
              ),
            ));
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
      var url = '$IPAdres/api/Appointments/GetConfirmedAppointmentsByUserId?id=$userId';
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
