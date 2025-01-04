class Product {
  final int id;
  final String name;
  String? description;
  String? brand;
  Map<String, String>? details;
  String? photo;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.brand,
    this.details,
    this.photo,
  });
}
