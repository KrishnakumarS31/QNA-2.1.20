import 'package:intl/intl.dart';

String todayDate() {
  final DateTime now = DateTime.now();
  late final DateFormat formatter = DateFormat('dd-MM-yyyy');
  late final String formatted = formatter.format(now);
  return formatted;
}



String convertDate(int? date)
{
  DateTime dateValue;
  dateValue = DateTime.fromMicrosecondsSinceEpoch(date!);
  return  "${dateValue.day}/${dateValue.month}/${dateValue.year}";
}

String convertTime(int? date)
{
  DateTime dateValue;
  dateValue = DateTime.fromMicrosecondsSinceEpoch(date!);
  return "${dateValue.hour}:${dateValue.minute}";
}
