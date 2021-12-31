import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/converters/log_level_to_color_converter.dart';
import 'package:flutter_logging_extensions/src/converters/log_level_to_icon_converter.dart';
import 'package:flutter_logging_extensions/src/filters/search_button.dart';
import 'package:flutter_logging_extensions/src/options_button.dart';
import 'package:logging_extensions/logging_extensions.dart';

import 'logs.dart';
import 'logs_controller_provider.dart';
import 'models/logs_controller.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({
    Key? key,
    this.colors = const LogLevelToColorConverter(),
    this.icons = const LogLevelToIconConverter(),
    this.controller,
    this.visualDensity = const VisualDensity(horizontal: 0, vertical: -4),
  }) : super(key: key);

  final Converter<Level, Color?> colors;
  final Converter<Level, IconData?> icons;
  final LogsController? controller;
  final VisualDensity visualDensity;

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  late LogsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? LogsController();
  }

  @override
  void didUpdateWidget(covariant LogsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? LogsController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LogsControllerProvider.builder(
      controller: _controller,
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          actions: const [
            SearchButton(),
            OptionsButton(),
          ],
        ),
        body: Logs(
          colors: widget.colors,
          icons: widget.icons,
          visualDensity: widget.visualDensity,
        ),
      ),
    );
  }
}
