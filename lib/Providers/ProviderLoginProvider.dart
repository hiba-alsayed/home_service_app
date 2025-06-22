import 'package:flutter/material.dart';
import '../Models/ProviderLoginModel.dart';

class ProviderLoginProvider with ChangeNotifier {
  ProviderLoginModel? _providerLoginModel;

  ProviderLoginModel? get getProviderModel => _providerLoginModel;

  String? get token => _providerLoginModel?.token;

  void setProviderModel(ProviderLoginModel? model) {
    _providerLoginModel = model;
    notifyListeners();
  }

  void updateToken(String token) {
    if (_providerLoginModel != null) {
      _providerLoginModel = ProviderLoginModel(
        message: _providerLoginModel!.message,
        token: token,
        roleName: _providerLoginModel!.roleName,
      );
      notifyListeners();
    }
  }
}

