import 'package:flutter/material.dart';
import '../Models/ProviderProfileModel.dart';
import '../Services/ProviderProfileService.dart';

class ProviderProfileProvider with ChangeNotifier {
  ProviderProfileModel? _profile;
  bool _isLoading = false;

  ProviderProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;

  final ProviderProfileService _service = ProviderProfileService();

  Future<void> fetchProviderProfile(dynamic providerId) async {
    _isLoading = true;
    notifyListeners();

    _profile = await _service.fetchProviderProfile(providerId);

    _isLoading = false;
    notifyListeners();
  }
}
