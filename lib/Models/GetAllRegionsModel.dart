import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class GetAllRegionsModel {
  dynamic id;
  dynamic region_name;


  GetAllRegionsModel ({
    required this.region_name,
    required this.id,

  });

  factory GetAllRegionsModel .fromJson(dynamic jsonData){
    return GetAllRegionsModel(
      id:jsonData["id"],
      region_name:jsonData["region_name"],
    );
  }
}

