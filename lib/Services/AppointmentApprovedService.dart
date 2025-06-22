import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';

class AppointmentApprovedService {
  String baseUrl = "http://$ipServer:8000";

  Future<void> submitRating({
    required String id,
    required String token,
    required double rating,
    required String comment,
  }) async {
    final url = Uri.parse('$baseUrl/api/client/appointment/rating/$id');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'status': 'approved',
        'rating': rating,
        'comment': comment,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit rating. Status code: ${response.statusCode}');
    }
  }

  Future<void> cancelAppointment({
    required String id,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/api/client/appointment/cancel/$id');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
        'status': 'canceled',
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorResponse = json.decode(response.body);
        throw Exception('Failed to cancel appointment. Status code: ${response.statusCode}, Error: ${errorResponse}');
      }
    } catch (error) {
      throw Exception('Failed to cancel appointment. Error: $error');
    }
  }
}
