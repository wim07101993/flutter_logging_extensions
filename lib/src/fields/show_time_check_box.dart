import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/logs_controller.dart';

class ShowTimeCheckBox extends StatelessWidget {
  const ShowTimeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LogsController.of(context);
    return ValueListenableBuilder<FieldVisibilitiesData>(
      valueListenable: controller.fields,
      builder: (context, fields, oldWidget) => Row(children: [
        Checkbox(
          value: fields.time,
          onChanged: (v) {
            LogsController.of(context).fields.value = fields.copyWith(
              time: v,
            );
          },
        ),
        const Text('Time'),
      ]),
    );
  }
}
