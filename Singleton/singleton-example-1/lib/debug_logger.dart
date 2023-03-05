import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

//Abstract Logger Class to showcase Singleton Pattern
//Wrapper Is Extension

abstract class BaseLogger {
  @protected
  late Logger _logger;
  @protected
  DateFormat _dateFormat = DateFormat('H:m:s.S');
  static const appName = 'singleton_pattern_example';

  void log(message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }
}

//Singleton wrapper by extension
class DebugLogger extends BaseLogger {
  static DebugLogger? _instance;

  DebugLogger._internal() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen(_recordHandler);
    _logger = Logger(BaseLogger.appName);
    debugPrint("<DebugLogger> Instance");
    _instance = this;
  }

  //Factory Constructor - Lazy Instantation
  factory DebugLogger() => _instance ?? DebugLogger._internal();

  //Record Handler
  void _recordHandler(LogRecord rec) {
    debugPrint('${_dateFormat.format(rec.time)}: ${rec.message} : ${rec.error}');
  }
}
