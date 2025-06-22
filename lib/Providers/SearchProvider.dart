// search_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/ServiceProviderSearchModel.dart';
import '../main.dart';


class SearchProvider with ChangeNotifier {
  List<ServiceProvider> _serviceProviders = [];
  bool _isLoading = false;

  List<ServiceProvider> get serviceProviders => _serviceProviders;
  bool get isLoading => _isLoading;

  Future<void> searchServiceProviders(dynamic providerName, dynamic serviceName) async {
    _isLoading = true;
    notifyListeners();

    final url = 'http://$ipServer:8000/api/search';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'provider_name': providerName,
        'service_name': serviceName,
      }),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      _serviceProviders = data.map((json) => ServiceProvider.fromJson(json)).toList();
    } else {
      _serviceProviders = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}