import 'package:flutter/foundation.dart';

class RegisterModel {

  dynamic message;
  dynamic token;
  dynamic roleId;
  dynamic roleName;

  RegisterModel({
    required this.message,
    required this.token,
  required this.roleId,
    required this.roleName,

  });

    factory RegisterModel.fromJson(dynamic jsonData){
      return RegisterModel(
        message: jsonData["message"],
        token: jsonData["data"]["token"],
        roleId: jsonData["data"]["roles"][0]["id"],
        roleName: jsonData["data"]["roles"][0]["name"],
      );
    }
}

