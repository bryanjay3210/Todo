import 'package:intl/intl.dart';

String dateTimeFormat(DateTime dateTime){
  return DateFormat('MM-dd-yyyy').format(dateTime);
}