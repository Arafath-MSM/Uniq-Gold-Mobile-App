class WooProductModel {
  WooProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currencyCode,
    required this.currencyMinorUnit,
    required this.imageUrl,
    required this.description,
    required this.categorySlugs,
  });

  final int id;
  final String name;
  final String price;
  final String currencyCode;
  final int currencyMinorUnit;
  final String imageUrl;
  final String description;
  final List<String> categorySlugs;

  factory WooProductModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> images = (json['images'] as List<dynamic>? ?? <dynamic>[]);
    final Map<String, dynamic>? firstImage =
        images.isNotEmpty ? images.first as Map<String, dynamic> : null;
    final List<dynamic> categories =
        (json['categories'] as List<dynamic>? ?? <dynamic>[]);

    return WooProductModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      price: (json['prices']?['price'] ?? '').toString(),
      currencyCode: (json['prices']?['currency_code'] ?? 'AED').toString(),
      currencyMinorUnit: json['prices']?['currency_minor_unit'] as int? ?? 2,
      imageUrl: firstImage?['src'] as String? ?? '',
      description:
          (json['short_description'] as String? ?? json['description'] as String? ?? ''),
      categorySlugs: categories
          .map((dynamic category) => ((category as Map<String, dynamic>)['slug'] ?? '').toString())
          .where((String slug) => slug.isNotEmpty)
          .toList(),
    );
  }
}
