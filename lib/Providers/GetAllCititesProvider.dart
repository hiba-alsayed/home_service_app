import 'package:flutter/material.dart';
import 'package:untitled1/Models/GetAllRegionsModel.dart';
import '../Models/ClientLoginModel.dart';
import '../Models/ClientRegisterModel.dart';
import '../Models/GetAllCitiesModel.dart';
import '../Models/GetAllServicesModel.dart';

class GetAllCitiesProvider with ChangeNotifier {


  List<GetAllCitiesModel >? _getAllCitiesModel;

  List<GetAllCitiesModel>? get getAllRegions =>_getAllCitiesModel;



  void setGetAllCitiesModel( List<GetAllCitiesModel >? model) {
    _getAllCitiesModel = model;
    notifyListeners();
  }

}
