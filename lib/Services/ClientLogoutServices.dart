import 'dart:convert';
import '../main.dart';
import 'package:http/http.dart' as http;

class ClientLogoutServices {
  String baseUrl = "http://$ipServer:8000";

  Future<Map<String, dynamic>> clientLogoutServices({
    required dynamic token,
  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/client/logout")
    );
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Authorization":'Bearer $token'
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      Map<String, dynamic>data1 = jsonDecode(data);
      print(data1);
      return data1;
    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}