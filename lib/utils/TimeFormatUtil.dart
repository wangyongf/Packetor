import 'package:fixnum/fixnum.dart';
import 'package:intl/intl.dart';

class TimeFormatUtil {
  static String format(Int64 time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time.toInt());
    var formatter = DateFormat('yyyy_MM_dd__HH_mm_ss_s');
    return formatter.format(date);
  }
}