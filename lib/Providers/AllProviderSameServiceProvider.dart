import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Models/AllProviderSameServiceModel.dart';
import '../main.dart';


class AllProviderSameProvider with ChangeNotifier {

  String? id;
  String? get getid =>id;

  void setid( String? model) {
    id = model;
    notifyListeners();
  }
  List<AllProviderSameServiceModel >? _getAllProviderSameincity;

  List<AllProviderSameServiceModel >? get getAllProviderSameincity =>_getAllProviderSameincity;



  void setAllProviderSameincityModel(List<AllProviderSameServiceModel>? model) {
    _getAllProviderSameincity = model;
    notifyListeners();
  }
  List<AllProviderSameServiceModel >? _getAllProviderSame;

  List<AllProviderSameServiceModel >? get getAllProviderSame =>_getAllProviderSame;



  void setAllProviderSameModel( List<AllProviderSameServiceModel>? model) {
    _getAllProviderSame = model;
    notifyListeners();
  }
}

