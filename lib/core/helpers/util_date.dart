import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilDate {
  static String today(
    String format,
    DateTime date,
  ) {
    initializeDateFormatting('id-ID', '');
    final today = DateFormat(format, 'id-ID').format(date.toLocal());
    return today;
  }
}
