import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/GetCitiesByRegionModel.dart';
import '../main.dart';

class GetCitiesByRegionServices {
  String baseUrl = "http://$ipServer:8000";

  Future<List<GetCitiesByRegionModel>> getAllCitiesByRegion({required dynamic region_id}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/regions/$region_id/cities"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data1 = jsonDecode(response.body);
      return data1.map((json) => GetCitiesByRegionModel.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception("The error in request: ${response.statusCode}");
    }
  }
}
