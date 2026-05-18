class Formatters {
  Formatters._();

  static String formatCurrency(num value) {
    return value.toStringAsFixed(2);
  }

  static String formatPriceLabel(String rawPrice, {int minorUnit = 2}) {
    if (rawPrice.isEmpty) {
      return 'AED --';
    }

    final int? parsed = int.tryParse(rawPrice);
    if (parsed == null) {
      return 'AED $rawPrice';
    }

    final num divisor = minorUnit <= 0 ? 1 : _pow10(minorUnit);
    final num normalized = parsed / divisor;
    return 'AED ${normalized.toStringAsFixed(2)}';
  }

  static num _pow10(int exponent) {
    num result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }
}
