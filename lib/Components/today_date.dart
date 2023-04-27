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
String convertDuration(int? duration)
{
  String assessmentDuration = "";
  if( duration!= null && duration> 60)
  {
    assessmentDuration = "${(duration/ 60).toStringAsFixed(2)} hrs";
  }
  if(duration != null && duration== 60)
  {
    assessmentDuration = "${(duration/ 60).toStringAsFixed(2)} hr";
  }
  else if(duration !=null && duration< 60)
  {
    assessmentDuration = "${(duration)} mins";
  }

  return assessmentDuration;
}
