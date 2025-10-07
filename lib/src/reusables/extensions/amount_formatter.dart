import 'package:intl/intl.dart';

extension AmountFormatter on num {
  String formatAmount() {
    final NumberFormat commaFormat = NumberFormat("#,##0");

    if (this >= 1000000000) {
      double value = this / 1000000000;
      return formatWithSuffix(value, 'B');
    } else if (this >= 1000000) {
      double value = this / 1000000;
      return formatWithSuffix(value, 'M');
    } else if (this >= 1000) {
      double value = this / 1000;
      return formatWithSuffix(value, 'K');
    } else {
      return commaFormat.format(this);
    }
  }

  /// Optional: format to full currency (₦, $, etc.)
  String asCurrency({String symbol = '₦'}) {
    final format = NumberFormat.currency(symbol: symbol, decimalDigits: 0);
    return format.format(this);
  }

  String formatWithSuffix(double value, String suffix) {
    if (value % 1 == 0) {
      return '${value.toInt()}$suffix';
    } else {
      return '${value.toStringAsFixed(1)}$suffix';
    }
  }
}
