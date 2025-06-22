// services/SearchService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';

import '../Models/AllProviderSameServiceModel.dart';

class SearchService {
  Future<List<AllProviderSameServiceModel>> searchProviders(dynamic query) async {
    final String url = 'http://$ipServer:8000/api/search';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data
            .map((json) => AllProviderSameServiceModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load providers');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}