import 'package:intl/intl.dart';

String todayDate()
{
  final DateTime now = DateTime.now();
  late final DateFormat formatter = DateFormat('dd-MM-yyyy');
  late final String formatted = formatter.format(now);
  return formatted;
}
