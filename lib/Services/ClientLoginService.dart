import 'dart:convert';
import 'package:untitled1/Models/ClientLoginModel.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class ClientLoginServices {
  String baseUrl = "http://$ipServer:8000";

  Future<ClientLoginModel> clientLoginServices({
    required dynamic email,
    required dynamic password,

  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/client/login")
    );
    request.fields.addAll({
      "email": email,
      "password": password,
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
      ClientLoginModel clientLoginModelModel=ClientLoginModel.fromJson(data1);
      return clientLoginModelModel;

    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}