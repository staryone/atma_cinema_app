class PromoModel {
  final String promoID;
  final String name;
  final String? description;
  final String? pathImage;
  final bool isFnb;

  PromoModel({
    required this.promoID,
    required this.name,
    this.description,
    this.pathImage,
    required this.isFnb,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      promoID: json['promoID'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      pathImage: json['pathImage'] as String?,
      isFnb: json['isFnb'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'promoID': promoID,
      'name': name,
      'description': description,
      'pathImage': pathImage,
      'isFnb': isFnb == true ? 1 : 0,
    };
  }
}
