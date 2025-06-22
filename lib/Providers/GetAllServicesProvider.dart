import 'package:flutter/material.dart';
import '../Models/GetAllServicesModel.dart';
import '../Services/GetAllServices.dart';

class GetAllServicesProvider with ChangeNotifier {
  List<GetAllServicesModel>? _getAllServicesModel;

  List<GetAllServicesModel>? get getAllServices => _getAllServicesModel;

  void setGetAllServicesModel(List<GetAllServicesModel>? model) {
    _getAllServicesModel = model;
    notifyListeners();
  }

  Future<void> fetchAllServices() async {
    try {
      List<GetAllServicesModel> services = await GetAllServices().getAllService();
      setGetAllServicesModel(services);
    } catch (e) {
      print('Error fetching services: $e');
    }
  }
}
