import 'package:intl/intl.dart';

/// Format Datetime
String dateTimeFormat(DateTime dateTime){
  return DateFormat('MM-dd-yyyy').format(dateTime);
}