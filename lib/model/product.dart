class Product {
  String id;
  String title;
  String description;
  String image;
  double price;
  double discount;
  int rating;
  List<dynamic> inCategories = [];
  List<dynamic> sizes = [];
  List<dynamic> colors = [];
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
  });
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
