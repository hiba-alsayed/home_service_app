import 'dart:convert';
import 'package:untitled1/Models/ClientLoginModel.dart';
import 'package:untitled1/Models/GetAllRegionsModel.dart';
import 'package:untitled1/Models/GetAllServicesModel.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class GetAllRegionServices {
  String baseUrl = "http://$ipServer:8000";

  Future<List<GetAllRegionsModel>> getAllRegions()

  async {
    var request = http.MultipartRequest(
        'GET',
        Uri.parse("$baseUrl/api/regions")
    );

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Accept": 'application/json',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      List<dynamic>data1 = jsonDecode(data);

      List<GetAllRegionsModel>allRegions=[];
      for(int i=0;i<data1.length;i++){
        allRegions.add(GetAllRegionsModel.fromJson(data1[i]));

      }
      return allRegions;


    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}