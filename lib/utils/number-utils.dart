import 'package:intl/intl.dart';

/// Formats a double [value] object in the currency format.
String getCurrency() => NumberFormat.simpleCurrency().currencySymbol;

/// Formats a double [value] object in the currency format.
String fmtMoney(double value) => NumberFormat.simpleCurrency().format(value);
