import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/flutter_logging_extensions.dart';
import 'package:flutter_logging_extensions/src/filters/logger_selector.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../faker_extensions.dart';

void main() {
  late Map<String, bool> fakeLoggers;
  late LogsController fakeController;

  setUp(() {
    fakeLoggers = {
      for (var i = 0; i < faker.randomGenerator.integer(10, min: 1); i++)
        faker.lorem.word(): faker.randomGenerator.boolean(),
    };

    fakeController = LogsController(
      filter: Filter(loggers: fakeLoggers),
    );
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      LogsControllerProvider.builder(
        controller: fakeController,
        builder: (context) => const MaterialApp(home: LoggerSelector()),
      ),
    );
    await tester.pumpAndSettle();
  }
}
