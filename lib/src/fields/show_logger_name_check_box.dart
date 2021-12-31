import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/models/field_visibilities.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';

class ShowLoggerNameCheckBox extends StatelessWidget {
  const ShowLoggerNameCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LogsController.of(context);
    return ValueListenableBuilder<FieldVisibilitiesData>(
      valueListenable: controller.fields,
      builder: (context, fields, oldWidget) => Row(children: [
        Checkbox(
          value: fields.loggerName,
          onChanged: (value) {
            controller.fields.value = fields.copyWith(loggerName: value);
          },
        ),
        const Text('Logger name'),
      ]),
    );
  }
}
