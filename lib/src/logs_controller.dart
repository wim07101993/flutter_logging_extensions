import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_logging_extensions/src/logs_controller_provider.dart';
import 'package:logging_extensions/logging_extensions.dart';

class LogsController extends ChangeNotifier
    implements ValueListenable<Iterable<LogRecord>> {
  LogsController({
    List<LogRecord> logs = const [],
    Filter? filter,
    FieldVisibilities? fields,
  })  : filter = filter ?? Filter(),
        fields = fields ?? FieldVisibilities(),
        loggers = ValueNotifier([]),
        levels = ValueNotifier([]),
        _allLogs = logs {
    this.filter.addListener(notifyListeners);
    updateLoggers();
    updateLevels();
  }

  final FieldVisibilities fields;
  final Filter filter;

  List<LogRecord> _allLogs;

  @override
  Iterable<LogRecord> get value => _allLogs.where(filter.apply);

  final ValueNotifier<List<String>> loggers;
  final ValueNotifier<List<Level>> levels;

  set value(Iterable<LogRecord> value) {
    _allLogs = value.toList(growable: false);
    notifyListeners();
    updateLoggers();
    updateLevels();
  }

  void updateLoggers() {
    final oldLoggers = loggers.value;
    final newLoggers = _allLogs.map((l) => l.loggerName).toSet().toList()
      ..sort();
    if (newLoggers.length != oldLoggers.length) {
      loggers.value = newLoggers;
    } else {
      for (var i = 0; i < newLoggers.length; i++) {
        if (newLoggers[i] != oldLoggers[i]) {
          loggers.value = newLoggers;
          break;
        }
      }
    }

    final selectedLoggers = Map<String, bool>.from(filter.loggers.value);
    for (final logger in loggers.value) {
      if (!selectedLoggers.containsKey(logger)) {
        selectedLoggers[logger] = true;
      }
    }
    filter.loggers.value = selectedLoggers;
  }

  void updateLevels() {
    final oldLevels = levels.value;
    final newLevels = _allLogs.map((l) => l.level).toSet().toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    if (newLevels.length != oldLevels.length) {
      levels.value = newLevels;
    } else {
      for (var i = 0; i < newLevels.length; i++) {
        if (newLevels[i] != oldLevels[i]) {
          levels.value = newLevels;
          break;
        }
      }
    }
  }

  static LogsController of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<LogsControllerProvider>();
    if (result == null) {
      throw AssertionError('No LogsController found in context');
    }
    return result.controller;
  }
}

class FieldVisibilities extends ValueNotifier<FieldVisibilitiesData> {
  FieldVisibilities([
    FieldVisibilitiesData fields = const FieldVisibilitiesData(),
  ]) : super(fields);
}

class FieldVisibilitiesData {
  const FieldVisibilitiesData({
    this.icon = false,
    this.loggerName = true,
    this.time = true,
  });

  final bool icon;
  final bool loggerName;
  final bool time;

  FieldVisibilitiesData copyWith({
    bool? icon,
    bool? loggerName,
    bool? time,
  }) {
    return FieldVisibilitiesData(
      icon: icon ?? this.icon,
      loggerName: loggerName ?? this.loggerName,
      time: time ?? this.time,
    );
  }
}

class Filter extends ChangeNotifier {
  Filter({
    String searchString = '',
    Level minimumLevel = Level.FINEST,
    Map<String, bool> loggers = const {},
  })  : searchString = ValueNotifier(searchString),
        minimumLevel = ValueNotifier(minimumLevel),
        loggers = ValueNotifier(loggers) {
    this.searchString.addListener(notifyListeners);
    this.minimumLevel.addListener(notifyListeners);
    this.loggers.addListener(notifyListeners);
  }

  final ValueNotifier<String> searchString;
  final ValueNotifier<Level> minimumLevel;
  final ValueNotifier<Map<String, bool>> loggers;

  bool apply(LogRecord logRecord) {
    final minimumLevel = this.minimumLevel.value;
    final loggers = this.loggers.value;
    final searchString = this.searchString.value;
    return logRecord.level.value >= minimumLevel.value &&
        (loggers.isEmpty || (loggers[logRecord.loggerName] ?? false)) &&
        (searchString.isEmpty || logRecord.message.contains(searchString));
  }

  @override
  void dispose() {
    searchString.removeListener(notifyListeners);
    minimumLevel.removeListener(notifyListeners);
    loggers.removeListener(notifyListeners);
    super.dispose();
  }
}
