import 'dart:async';
import 'dart:convert';

import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class ApiService{

  Future<GetTimesModels?> getDoctorAppointment({required DateTime selectDate}) async {
    var url = 'http://192.168.50.225:5297/api/Schedules/GetTimeSlots';
    var queryParams = {
      'currentDay':
      '${DateFormat("yyyy-MM-dd").format(selectDate)}T00:00:00Z',
      'doctorId': '2',

    };
    print(queryParams);
    var uri = Uri.parse(url).replace(queryParameters: queryParams);
      var response = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      });
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetTimesModels? getTimesModels =
        GetTimesModels.fromJson(jsonDecode(response.body));
        return getTimesModels;
      }
    return null;
  }
  Future<void> submitAppointment({required DateTime selectDate,required String time}) async {
    final url = Uri.parse('http://192.168.50.225:5297/api/Appointments/Create');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "name": "string",
      "email": "string",
      "phoneNumber": "string",
      "age": "string",
      'date': '${DateFormat("yyyy-MM-dd").format(selectDate)}T$time:00Z',
      "doctorId": 2

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

}