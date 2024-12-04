class StudioModel {
  final String studioID;
  final String name;
  final int capacity;

  StudioModel({
    required this.studioID,
    required this.name,
    required this.capacity,
  });

  factory StudioModel.fromJson(Map<String, dynamic> json) {
    return StudioModel(
      studioID: json['studioID'],
      name: json['name'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studioID': studioID,
      'name': name,
      'capacity': capacity,
    };
  }
}
