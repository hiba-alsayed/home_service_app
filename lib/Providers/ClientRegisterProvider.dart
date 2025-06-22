import 'package:flutter/material.dart';
import '../Models/ClientRegisterModel.dart';

class ClientRegisterProvider with ChangeNotifier {
  RegisterModel? _registerModel;
  int?city_id;

  int? get ctiy_idget => city_id;

  void setCityId(int? id) {
    city_id = id;
    notifyListeners();
  }
  RegisterModel? get registerModel => _registerModel;

  void setRegisterModel(RegisterModel? model) {
    _registerModel = model;
    notifyListeners();

  }



}
