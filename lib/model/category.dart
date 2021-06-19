// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.subCategories,
  });

  String id;
  String title;
  String image;
  List<dynamic> subCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        subCategories: List<dynamic>.from(json["sub_categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "subCategories": List<dynamic>.from(subCategories.map((x) => x)),
      };
}
