import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/converters/log_level_to_color_converter.dart';
import 'package:flutter_logging_extensions/src/converters/log_level_to_icon_converter.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';
import 'package:logging_extensions/logging_extensions.dart';

import 'log_list_item.dart';

class Logs extends StatefulWidget {
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
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Iterable<LogRecord>>(
      valueListenable: LogsController.of(context),
      builder: (context, value, oldWidget) {
        final logs = value.toList(growable: false);
        if (scrollController.positions.isNotEmpty &&
            scrollController.position.hasContentDimensions &&
            scrollController.offset ==
                scrollController.position.maxScrollExtent) {
          scrollToBottom();
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: logs.length,
          itemBuilder: (context, i) {
            final logRecord = logs[i];
            return LogListItem(
              logRecord: logs[i],
              icon: widget.icons.convert(logRecord.level),
              color: widget.colors.convert(logRecord.level),
              visualDensity: widget.visualDensity,
              detailScreenBuilder: widget.detailScreenBuilder,
            );
          },
        );
      },
    );
  }

  Future scrollToBottom() {
    if (scrollController.positions.isEmpty) {
      return Future.value();
    }
    return Future.delayed(
      const Duration(milliseconds: 1),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
    );
  }
}
