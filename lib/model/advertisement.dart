class Advertisement {
  String id;
  String title;
  String image;
  Advertisement({
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
