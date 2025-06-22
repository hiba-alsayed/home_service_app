import 'package:flutter/foundation.dart';

class GetCitiesByRegionModel {
  dynamic id;
  dynamic city_name;
  dynamic region_id;

  GetCitiesByRegionModel({
    required this.city_name,
    required this.id,
    required this.region_id,
  });

  factory GetCitiesByRegionModel.fromJson(dynamic jsonData) {
    return GetCitiesByRegionModel(
      id: jsonData["id"],
      city_name: jsonData["city_name"], // تعديل هنا
      region_id: jsonData["region_id"],
    );
  }
}
