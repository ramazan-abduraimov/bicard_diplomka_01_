import 'dart:async';
import 'dart:convert';

import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Doctor_Details.dart';
import 'package:bicard_diplomka_01_/models/get_Doctors_model.dart';
import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static const String IPAdres = "http://192.168.50.226:5297";

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

  Future<void> submitAppointment(
      {required DateTime selectDate,
      required String time,
      required int id}) async {
    print(id);
    final url = Uri.parse('$IPAdres/api/Appointments/Create');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "name": "Asan",
      "email": "string",
      "phoneNumber": "string",
      "age": "string",
      'date': '${DateFormat("yyyy-MM-dd").format(selectDate)}T$time:00Z',
      "doctorId": id,

      //  'DoctorID': 2,
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
  }

  Future<List<DoctorModel>> fetchDoctorsList() async {
    try {
      var url = 'http://192.168.50.226:5297/api/Doctors/GetListOfDoctors';
      var uri = Uri.parse(url).replace(queryParameters: {'speciality': ''});
      ;
      final response = await http.get(uri);
      if (response.statusCode == 200) {
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

  Future<void> sendDoctorId(String doctorId) async {
    final url = Uri.parse(
        'http://192.168.50.226:5297/api/Doctors/GetDoctorById?id=$doctorId');
    print("${doctorId}");
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Handle success response
        print('Request successful');
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Request failed with error: $e');
    }
  }
}
