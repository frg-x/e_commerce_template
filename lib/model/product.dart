// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.discount,
    required this.rating,
    required this.inCategories,
    required this.sizes,
    required this.colors,
    required this.bigPhotos,
    required this.reviews,
  });

  String id;
  String title;
  String description;
  String image;
  double price;
  double discount;
  int rating;
  List<dynamic> inCategories;
  List<dynamic> sizes;
  List<dynamic> colors;
  List<dynamic> bigPhotos;
  String reviews;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        price: json["price"].toDouble(),
        discount: json["discount"].toDouble(),
        rating: json["rating"],
        inCategories: List<dynamic>.from(json["in_categories"].map((x) => x)),
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        bigPhotos: List<dynamic>.from(json["big_photos"].map((x) => x)),
        reviews: json["reviews"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "price": price,
        "discount": discount,
        "rating": rating,
        "inCategories": List<dynamic>.from(inCategories.map((x) => x)),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "bigPhotos": List<dynamic>.from(bigPhotos.map((x) => x)),
        "reviews": reviews,
      };
}
