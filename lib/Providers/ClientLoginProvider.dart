import 'package:flutter/material.dart';
import '../Models/ClientLoginModel.dart';
import '../Models/ClientRegisterModel.dart';

class ClientLoginProvider with ChangeNotifier {


  ClientLoginModel ? _clientLoginModel;

  ClientLoginModel? get getClientModel =>_clientLoginModel;

  void setClientModel(ClientLoginModel? model) {
    _clientLoginModel = model;
    notifyListeners();
  }
}
