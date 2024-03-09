import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// 17 Agustus
const monthDay = 'd MMMM';
// Agustus 1945
const monthYear = 'MMMM yyyy';
// 17 Agustus 1945
const dmy = 'dd MMMM yyyy';
// 17/10/1945 20:08
const ddMMyyy = 'dd/MM/yyyy HH:mm';

class TimeUtil {
  String today(
    String format,
    DateTime date,
  ) {
    initializeDateFormatting('id-ID', '');
    final today = DateFormat(format).format(date.toLocal());
    return today;
  }
}
