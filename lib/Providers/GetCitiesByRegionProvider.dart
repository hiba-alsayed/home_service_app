import 'package:flutter/material.dart';
import 'package:untitled1/Models/GetCitiesByRegionModel.dart';

class GetCitiesByRegionProvider with ChangeNotifier {
  List<GetCitiesByRegionModel>? _getCitiesByRegionModel;

  List<GetCitiesByRegionModel>? get getCitiesByRegion => _getCitiesByRegionModel;

  void setGetCitiesByRegionModel(List<GetCitiesByRegionModel>? model) {
    _getCitiesByRegionModel = model;
    notifyListeners();
  }
}
