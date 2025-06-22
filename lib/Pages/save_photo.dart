// profile_image_provider.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageProvider extends ChangeNotifier {
  XFile? _profileImage;

  XFile? get profileImage => _profileImage;

  Future<void> setProfileImage(XFile? image) async {
    _profileImage = image;
    notifyListeners();
  }
}

class ProfilenameProvider with ChangeNotifier {
  String _name = 'John Doe';

  String get name => _name;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }
}

