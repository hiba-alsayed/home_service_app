import 'dart:convert';
import 'package:untitled1/Models/ClientRegisterModel.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class ClientRegisterServices {
  String baseUrl = "http://$ipServer:8000";

  Future<RegisterModel> registerServices({
    required dynamic name,
    required dynamic email,
    required dynamic password,
    required dynamic city_id,
    required dynamic deviceToken,
  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/client/register")
    );
    request.fields.addAll({
      "name":name,
      "email": email,
      "password": password,
      "city_id":city_id,
      "device_token": deviceToken,

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
      RegisterModel registerModel=RegisterModel.fromJson(data1);
      return registerModel;
    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}