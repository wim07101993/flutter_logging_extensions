import 'package:flutter/material.dart';
import 'package:logging_extensions/logging_extensions.dart';

class LogLevelToColorConverter extends LogLevelConverter<Color?> {
  const LogLevelToColorConverter()
      : super(
          defaultValue: null,
          finest: Colors.grey,
          finer: Colors.grey,
          config: Colors.green,
          info: Colors.blue,
          warning: Colors.deepOrange,
          severe: Colors.red,
          shout: Colors.purple,
        );
}
