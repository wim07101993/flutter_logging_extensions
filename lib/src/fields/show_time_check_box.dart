import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/models/field_visibilities.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';

class ShowTimeCheckBox extends StatelessWidget {
  const ShowTimeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LogsController.of(context);
    return ValueListenableBuilder<FieldVisibilitiesData>(
      valueListenable: controller.visibleFields,
      builder: (context, fields, oldWidget) => Row(children: [
        Checkbox(
          value: fields.time,
          onChanged: (v) =>
              controller.visibleFields.value = fields.copyWith(time: v),
        ),
        const Text('Time'),
      ]),
    );
  }
}
