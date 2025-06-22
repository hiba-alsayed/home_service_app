import 'package:flutter/foundation.dart';
class ClientLoginModel {
  dynamic message;
  dynamic token;
  //dynamic roleId;
  List<dynamic> roleName;

  ClientLoginModel({
    required this.message,
    required this.token,
  //  required this.roleId,
    required this.roleName,

  });

  factory ClientLoginModel.fromJson(dynamic jsonData){
    return ClientLoginModel(
      message: jsonData["message"],
      token: jsonData["data"]["user"]["token"],
     // roleId: jsonData["data"]["roles"][0]["id"],
      roleName: jsonData["data"]["roles"],
    );
  }
}

