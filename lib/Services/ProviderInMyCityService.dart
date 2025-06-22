import 'dart:convert';
import 'package:untitled1/Models/AllProviderSameServiceModel.dart';
import 'package:untitled1/Models/ClientLoginModel.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class ProviderInMyCityService {
  String baseUrl = "http://$ipServer:8000";

  Future<List<AllProviderSameServiceModel>> providerInMyCityService({
    required dynamic serviceID,
    required dynamic token,

  }) async {
    var request = http.MultipartRequest(
        'GET',
        Uri.parse("$baseUrl/api/service/providersBy/city/$serviceID")
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
      List<dynamic>data1 = jsonDecode(data);

      List<AllProviderSameServiceModel>allaProvider=[];
      for(int i=0;i<data1.length;i++){
        allaProvider.add(AllProviderSameServiceModel.fromJson(data1[i]));
      }
      return allaProvider;
    }
    else {
      print(response.statusCode);
      throw Exception({"the error in request :${response.statusCode}"});
    }
  }
}