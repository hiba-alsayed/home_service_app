import 'package:flutter/material.dart';
import 'package:untitled1/Models/GetAllRegionsModel.dart';
import '../Models/ClientLoginModel.dart';
import '../Models/ClientRegisterModel.dart';
import '../Models/GetAllServicesModel.dart';

class GetAllRegionsProvider with ChangeNotifier {


  List<GetAllRegionsModel >? _getAllRegionsModel;

  List<GetAllRegionsModel >? get getAllRegions =>_getAllRegionsModel;



  void setGetAllRegionsModel( List<GetAllRegionsModel >? model) {
    _getAllRegionsModel = model;
    notifyListeners();
  }

}
