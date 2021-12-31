import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/converters/log_level_to_color_converter.dart';
import 'package:flutter_logging_extensions/src/converters/log_level_to_icon_converter.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';
import 'package:logging_extensions/logging_extensions.dart';

import 'log_list_item.dart';

class Logs extends StatelessWidget {
  const Logs({
    Key? key,
    this.colors = const LogLevelToColorConverter(),
    this.icons = const LogLevelToIconConverter(),
    this.visualDensity = const VisualDensity(horizontal: 0, vertical: -4),
    this.detailScreenBuilder,
  }) : super(key: key);

  final Converter<Level, Color?> colors;
  final Converter<Level, IconData?> icons;
  final VisualDensity visualDensity;
  final Widget Function(LogRecord log)? detailScreenBuilder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Iterable<LogRecord>>(
      valueListenable: LogsController.of(context),
      builder: (context, value, oldWidget) {
        final logs = value.toList(growable: false);
        return ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, i) {
            final logRecord = logs[i];
            return LogListItem(
              logRecord: logs[i],
              icon: icons.convert(logRecord.level),
              color: colors.convert(logRecord.level),
              visualDensity: visualDensity,
              detailScreenBuilder: detailScreenBuilder,
            );
          },
        );
      },
    );
  }
}
