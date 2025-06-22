import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';
import '../Providers/ProviderLoginProvider.dart';

class EmergencyService {
  Future<bool> createEmergency({
    required String serviceId,
    required String description,
    required String token,
  }) async {
    final String url = 'http://$ipServer:8000/api/emergency/create/1';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['message'] == 'Emergency created and providers notified.') {
          return true;
        } else {
          return false;
        }
      } else {
        print('Error: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}