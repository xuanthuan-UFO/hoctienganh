import 'package:flutter/foundation.dart';

class UfoLogger {
  static UfoLogger _shareInstance = UfoLogger._instance();

  factory UfoLogger() => _shareInstance;

  UfoLogger._instance();

  void writeLog(String logs) {
    if (kDebugMode) {
      print('$logs');
    }
  }
}