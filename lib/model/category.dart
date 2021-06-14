class Category {
  String id;
  String title;
  String image;
  Category({
    required this.id,
    required this.title,
    required this.image,
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
