import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/fields/show_icons_check_box.dart';
import 'package:flutter_logging_extensions/src/fields/show_logger_name_check_box.dart';
import 'package:flutter_logging_extensions/src/fields/show_time_check_box.dart';
import 'package:flutter_logging_extensions/src/logs_controller_provider.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';

class FieldsScreen extends StatelessWidget {
  const FieldsScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LogsController controller;

  @override
  Widget build(BuildContext context) {
    return LogsControllerProvider.builder(
      controller: controller,
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Visible fields'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: const [
              ShowIconCheckBox(),
              ShowLoggerNameCheckBox(),
              ShowTimeCheckBox(),
            ]),
          ),
        ),
      ),
    );
  }
}
