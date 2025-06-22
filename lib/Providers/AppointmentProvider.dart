import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';
import 'dart:convert';
import '../Models/Appointment.dart';


class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];
  List<Appointment> get appointments => _appointments;

  Future<void> fetchAppointments(String token) async {
    final url = Uri.parse('http://$ipServer:8000/api/client/appointment/get');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final appointmentsList = data['Appointments'] as List;
      _appointments = appointmentsList.map((json) => Appointment.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load appointments');
    }
  }
}