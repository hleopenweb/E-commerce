import 'package:intl/intl.dart';

bool hasWhiteSpace(String value) {
  return value.contains(' ');
}
final _formatterFullDate = DateFormat('dd/MM/yyyy');

final _formatterFullDateTime = DateFormat('dd/MM/yyyy HH:mm:ss');

String formatterFullDate(DateTime dateTime) => _formatterFullDate.format(dateTime);

String formatterFullDateTime(DateTime dateTime) => _formatterFullDateTime.format(dateTime);
