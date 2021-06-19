// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.favProducts,
  });

  String id;
  List<dynamic> favProducts;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        favProducts: List<dynamic>.from(json["favProducts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "favProducts": List<dynamic>.from(favProducts.map((x) => x)),
      };
}
