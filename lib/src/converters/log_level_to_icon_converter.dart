import 'package:flutter/material.dart';
import 'package:logging_extensions/logging_extensions.dart';

class LogLevelToIconConverter extends LogLevelConverter<IconData?> {
  const LogLevelToIconConverter()
      : super(
          defaultValue: null,
          finest: Icons.code,
          finer: Icons.bug_report,
          config: Icons.settings,
          info: Icons.info,
          warning: Icons.warning,
          severe: Icons.error,
          shout: Icons.bolt,
        );
}
