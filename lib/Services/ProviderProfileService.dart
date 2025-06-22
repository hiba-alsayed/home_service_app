import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';
import '../Models/ProviderProfileModel.dart';

class ProviderProfileService {
  Future<ProviderProfileModel?> fetchProviderProfile(dynamic providerId) async {
    final response = await http.get(Uri.parse('http://$ipServer:8000/api/getProfile/$providerId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return ProviderProfileModel.fromJson(data[0]);
      }
    }
    print(response.statusCode);
    throw Exception({"the error in request :${response.statusCode}"});
  }
}
