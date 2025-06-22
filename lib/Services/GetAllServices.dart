import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/GetAllServicesModel.dart';
import '../main.dart';

class GetAllServices {
  String baseUrl = "http://$ipServer:8000";

  Future<List<GetAllServicesModel>> getAllService() async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse("$baseUrl/api/service/all"),
    );

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Accept": 'application/json',
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      List<dynamic> jsonData = jsonDecode(data);

      List<GetAllServicesModel> allServices = jsonData.map((service) {
        return GetAllServicesModel.fromJson(service);
      }).toList();
      return allServices;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Error in request: ${response.statusCode}');
    }
  }
}
