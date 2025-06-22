import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class GetAllCitiesModel {
  dynamic id;
  dynamic city_name;


  GetAllCitiesModel({
    required this.city_name,
    required this.id,

  });

  factory GetAllCitiesModel.fromJson(dynamic jsonData){
    return GetAllCitiesModel (
      id:jsonData["id"],
      city_name:jsonData["city_name"],
    );
  }
}

