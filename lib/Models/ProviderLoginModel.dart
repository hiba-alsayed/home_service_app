import 'package:flutter/foundation.dart';

class ProviderLoginModel {
  final dynamic message;
  final dynamic token;
  final List<dynamic> roleName;

  ProviderLoginModel({
    required this.message,
    required this.token,
    required this.roleName,
  });

  factory ProviderLoginModel.fromJson(Map<String, dynamic> jsonData) {
    try {
      if (jsonData["data"]["roles"] is List && jsonData["data"]["roles"].isNotEmpty) {
        return ProviderLoginModel(
          message: jsonData["message"],
          token: jsonData["data"]["user"]["token"],
          roleName: jsonData["data"]["roles"],
        );
      } else {
        throw Exception("Roles array is either missing or empty");
      }
    } catch (e) {
      throw Exception("Error parsing ProviderLoginModel: ${e.toString()}");
    }
  }
}
