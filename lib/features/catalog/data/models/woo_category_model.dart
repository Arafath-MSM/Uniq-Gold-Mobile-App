class WooCategoryModel {
  WooCategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String imageUrl;

  factory WooCategoryModel.fromJson(Map<String, dynamic> json) {
    return WooCategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      imageUrl: (json['image']?['src'] ?? '').toString(),
    );
  }
}
