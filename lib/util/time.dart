import 'package:intl/intl.dart';

String getFormattedTime(DateTime time) {
  final formattedTime = DateFormat('yyyy-MM-ddThh:mm:ss').format(time);
  return formattedTime;
}

String getDateFromString(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return '${date.day}/${date.month}/${date.year}';
}
