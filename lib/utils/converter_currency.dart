import 'package:intl/intl.dart';

final currencyFormatter = NumberFormat.currency(locale: 'vi');

String formatCurrency(int currency) => currencyFormatter.format(currency);
