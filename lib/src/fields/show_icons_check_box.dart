import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/models/field_visibilities.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';

class ShowIconCheckBox extends StatelessWidget {
  const ShowIconCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LogsController.of(context);
    return ValueListenableBuilder<FieldVisibilitiesData>(
      valueListenable: controller.visibleFields,
      builder: (context, fields, oldWidget) => Row(children: [
        Checkbox(
          value: fields.icon,
          onChanged: (v) =>
              controller.visibleFields.value = fields.copyWith(icon: v),
        ),
        const Text('Icon'),
      ]),
    );
  }
}
