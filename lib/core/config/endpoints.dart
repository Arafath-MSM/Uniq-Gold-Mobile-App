class Endpoints {
  Endpoints._();

  static const String storeProducts = '/wp-json/wc/store/v1/products';
  static const String storeCategories = '/wp-json/wc/store/v1/products/categories';
  static const String cart = '/wp-json/wc/store/v1/cart';
  static const String checkout = '/wp-json/wc/store/v1/checkout';
  static const String login = '/wp-json/uniqgold/v1/auth/login';
  static const String profile = '/wp-json/uniqgold/v1/me';

  static String storeProductById(String id) => '$storeProducts/$id';
}
