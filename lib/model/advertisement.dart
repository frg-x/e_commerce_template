import 'dart:convert';

Advertisement advertisementFromJson(String str) =>
    Advertisement.fromJson(json.decode(str));

String advertisementToJson(Advertisement data) => json.encode(data.toJson());

class Advertisement {
  Advertisement({
    required this.id,
    required this.title,
    required this.image,
  });

  String id;
  String title;
  String image;

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
