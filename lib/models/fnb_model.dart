class FnbModel {
  final String fnbID;
  final String name;
  final String category;
  final String? description;
  final double price;
  final String? pathImage;

  FnbModel({
    required this.fnbID,
    required this.name,
    required this.category,
    this.description,
    required this.price,
    this.pathImage,
  });

  factory FnbModel.fromJson(Map<String, dynamic> json) {
    return FnbModel(
      fnbID: json['fnbID'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String?,
      price: double.parse(json['price']),
      pathImage: json['pathImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fnbID': fnbID,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'pathImage': pathImage,
    };
  }
}
