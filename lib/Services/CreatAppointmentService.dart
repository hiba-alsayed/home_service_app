import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';
import '../Models/CreatAppointmentModel.dart';

class CreatAppointementService {
  String baseUrl = "http://$ipServer:8000";

  Future<Map<String,dynamic>> creatAppointementService({
    required dynamic id,
    required dynamic token,
    required dynamic date,
    required dynamic hours,
    required dynamic description,
  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/client/appointment/create/$id")
    );
    request.fields.addAll({
      "date": date,
      "hours": hours,
      "description":description,
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Authorization":'Bearer $token'
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200|| response.statusCode == 201) {
      String data = await response.stream.bytesToString();
      Map<String, dynamic>data1 = jsonDecode(data);
      return data1;

    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}
