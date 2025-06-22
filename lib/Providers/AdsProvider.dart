import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';
import '../Models/AdModel.dart';

class AdsProvider with ChangeNotifier {
  List<AdModel> _ads = [];

  List<AdModel> get ads => _ads;

  Future<void> fetchAds() async {
    final url = 'http://$ipServer:8000/api/provider/ads';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body)['data'];
        List<AdModel> loadedAds = [];
        responseData.forEach((key, value) {
          loadedAds.add(AdModel.fromJson(value));
        });
        _ads = loadedAds;
        notifyListeners();
      } else {
        throw Exception('Failed to load ads');
      }
    } catch (error) {
      throw (error);
    }
  }
}
