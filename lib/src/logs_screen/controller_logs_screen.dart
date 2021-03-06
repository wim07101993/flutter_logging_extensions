import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/flutter_logging_extensions.dart';
import 'package:flutter_logging_extensions/src/filters/search_button.dart';
import 'package:flutter_logging_extensions/src/options_button.dart';

class ControllerLogsScreen extends StatelessWidget implements LogsScreen {
  const ControllerLogsScreen({
    Key? key,
    required this.controller,
    this.colors = const LogLevelToColorConverter(),
    this.icons = const LogLevelToIconConverter(),
    this.visualDensity = const VisualDensity(horizontal: 0, vertical: -4),
  }) : super(key: key);

  final LogsController controller;
  final Converter<Level, Color?> colors;
  final Converter<Level, IconData?> icons;
  final VisualDensity visualDensity;

  @override
  Widget build(BuildContext context) {
    return LogsControllerProvider.builder(
      controller: controller,
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          actions: const [
            SearchButton(),
            OptionsButton(),
          ],
        ),
        body: Logs(
          colors: colors,
          icons: icons,
          visualDensity: visualDensity,
        ),
      ),
    );
  }
}
