import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_logging_extensions/src/logs_controller_provider.dart';
import 'package:flutter_logging_extensions/src/models/field_visibilities.dart';
import 'package:flutter_logging_extensions/src/models/filter.dart';
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
    final newLevels = {
      ...Level.LEVELS,
      ..._allLogs.map((l) => l.level),
    }.toList()
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
