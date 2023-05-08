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

String convertAttemptDuration(int? duration) {
  String assessmentDuration = '';
  if (duration!< 60) {
    if (duration.toString().length == 1) {
      assessmentDuration = "00:0$duration min";
    }
    else if (duration.toString().length == 2)
    {
      assessmentDuration = "00:$duration min";
    }
  }

  else if(duration == 60)
    {
      assessmentDuration = "01:00 hr";
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
      assessmentDuration = "$f:$d hrs";
    }
    else if(ch[1].length == 2) {
      b= ch[1];
      d= (int.parse(b)) * 60;
      assessmentDuration = "$f:$d min";
    }}

    else if(ch.length ==1)
      {
        assessmentDuration ="$f:00 hrs";
      }

  }


  return assessmentDuration;
}
