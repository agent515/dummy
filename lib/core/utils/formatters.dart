abstract final class Formatters {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// `9.99` → `$9.99`. DummyJSON prices are USD.
  static String price(double value) => '\$${value.toStringAsFixed(2)}';

  /// `10.48` → `-10%`.
  static String discount(double percentage) => '-${percentage.round()}%';

  /// `2025-04-30` → `Apr 30, 2025`.
  static String date(DateTime date) {
    final local = date.toLocal();
    return '${_months[local.month - 1]} ${local.day}, ${local.year}';
  }
}
