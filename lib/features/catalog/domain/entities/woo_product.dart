class WooProduct {
  WooProduct({
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
}
