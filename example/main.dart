import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/flutter_logging_extensions.dart';

final logger = Logger('root');
final secondLogger = Logger('my-custom-logger');

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  final sink = MemoryLogSink.variableBuffer()..listenTo(logger.onRecord);

  logger.finest('This is a verbose message');
  logger.finer('This is a debug message');
  secondLogger.fine('This is a fine message');
  logger.config('Configured api');
  logger.info('This actually looks quiet nice');
  secondLogger.warning('Null-pointers ahead');
  logger.severe(
    'Null reference exception ...',
    NullThrownError(),
    StackTrace.current,
  );
  secondLogger.shout('I told you to look out for null-pointers');
  secondLogger.finest('This is a verbose message');
  secondLogger.finer('This is a debug message');
  logger.fine('This is a fine message');
  secondLogger.config('Configured api');
  secondLogger.info('This actually looks quiet nice');
  logger.warning('Null-pointers ahead');
  secondLogger.severe(
    'Null reference exception ...',
    NullThrownError(),
    StackTrace.current,
  );
  logger.shout('I told you to look out for null-pointers');

  final controller = LogsController(logs: sink.logRecords);
  runApp(MaterialApp(
    home: LogsScreen(controller: controller),
  ));
}
