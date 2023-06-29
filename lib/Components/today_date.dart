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
  String month = DateFormat('MMMM').format(DateTime(0, dateValue.month)).substring(0,3);
  return  "${dateValue.day}-$month-${dateValue.year}";
}

String convertDateFromString(String date)
{
  String month = date.substring(3,5);
  int m = int.parse(month);
  month = DateFormat('MMMM').format(DateTime(0,m)).substring(0,3);
  date =  date.replaceRange(3, 5, month);
  return date;
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

String convertAttemptDuration(int? duration) {
  String assessmentDuration = '';
  if (duration!< 60) {
    if (duration.toString().length == 1) {
      duration = duration == 0 ?  1 : duration;
      assessmentDuration = "00h 0${duration}m";
    }
    else if (duration.toString().length == 2)
    {
      assessmentDuration = "00h ${duration}m";
    }
  }

  else if(duration == 60)
  {
    assessmentDuration = "01h 00m";
  }

  else if (duration> 60) {
    int d=0;
    int f;
    List<String> ch;
    String b;
    double c;
    double g = duration / 60;
    f = g.toInt();
    ch = g.toString().split(".");
    if(ch.length == 2)
    { if( ch[1].length == 1)
    {
      b= "0.${ch[1]}";
      c= double.parse(b);
      d = (c*60).toInt();
      assessmentDuration = "${f}h:${d}m";
    }
    else if(ch[1].length == 2) {
      b= ch[1];
      d= (int.parse(b)) * 60;
      assessmentDuration = "${f}h:${d}m";
    }}

    else if(ch.length ==1)
    {
      assessmentDuration ="${f}h:00m";
    }

  }


  return assessmentDuration;
}
