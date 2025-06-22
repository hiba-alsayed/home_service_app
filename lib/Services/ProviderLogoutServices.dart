import 'dart:convert';
import '../main.dart';
import 'package:http/http.dart' as http;

class ProviderLogoutServices {
  String baseUrl = "http://$ipServer:8000";

  Future<Map<String, dynamic>> providerLogoutServices({
    required String token,
  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/provider/logout")
    );
    Map<String, String> headers = {
      "Content-Type": 'application/json',
      "Accept": 'application/json',
      "Authorization": 'Bearer $token'
    };
    request.headers.addAll(headers);
    print("Request Headers: ${request.headers}");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      Map<String, dynamic> data1 = jsonDecode(data);
      print("Response Data: $data1");
      return data1;
    } else {
      print("Response Status Code: ${response.statusCode}");
      print("Response Reason Phrase: ${response.reasonPhrase}");
      throw Exception("Error in request: ${response.statusCode}");
    }
  }
}
