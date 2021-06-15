class Category {
  String id;
  String title;
  String image;
  List<dynamic> subCategories;
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.subCategories,
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
