import 'package:budget_in/core/core.dart';
import 'package:budget_in/injection.dart';

class Helpers {
  static String getErrorMessageFromEndpoint(
      dynamic dynamicErrorMessage, String httpErrorMessage, int statusCode) {
    if (dynamicErrorMessage is Map &&
        dynamicErrorMessage.containsKey('reason') &&
        dynamicErrorMessage['reason'].isNotEmpty) {
      return 'status code : $statusCode || error: ${dynamicErrorMessage['reason']}';
    } else if (dynamicErrorMessage is Map &&
        dynamicErrorMessage.containsKey('message') &&
        dynamicErrorMessage['message'].isNotEmpty) {
      return 'status code : $statusCode || error: ${dynamicErrorMessage['message']}';
    } else if (dynamicErrorMessage is String) {
      return httpErrorMessage;
    } else {
      return httpErrorMessage;
    }
  }

  static String getUid() {
    final spf = sl<SharedPreferencesManager>();
    return spf.getString(SharedPreferencesManager.keyUid) ?? '';
  }

  static String replaceString(String v) {
    return v.replaceAll(RegExp('.'), "*");
  }
}
