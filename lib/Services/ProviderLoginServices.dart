import 'dart:convert';
import 'package:untitled1/Models/ProviderLoginModel.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class ProviderLoginServices {
  String baseUrl = "http://$ipServer:8000";

  Future<ProviderLoginModel> loginServices({
    required dynamic email,
    required dynamic password,
    required dynamic deviceToken,
  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/provider/login")
    );
    request.fields.addAll({
      "email": email,
      "password": password,
      "device_token": deviceToken
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Accept": 'application/json',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      Map<String, dynamic>data1 = jsonDecode(data);
     ProviderLoginModel providerLoginModel=ProviderLoginModel.fromJson(data1);
      return providerLoginModel;
    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}