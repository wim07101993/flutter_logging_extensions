import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/src/filters/select_loggers_dialog.dart';
import 'package:flutter_logging_extensions/src/models/logs_controller.dart';

class LoggerSelector extends StatelessWidget {
  const LoggerSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = LogsController.of(context);
    return ValueListenableBuilder<Map<String, bool>>(
      valueListenable: controller.filter.loggers,
      builder: (context, loggers, oldWidget) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _loggers(
              theme,
              loggers.entries.where((e) => e.value).map((e) => e.key).toList(),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => _selectLogger(context),
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  Widget _loggers(ThemeData theme, List<String> loggers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Loggers', style: theme.textTheme.caption),
        Text(
          loggers.isEmpty
              ? 'None'
              : loggers.toString().replaceAll('[', '').replaceAll(']', ''),
        ),
      ],
    );
  }

  void _selectLogger(BuildContext context) {
    final controller = LogsController.of(context);
    showDialog(
      context: context,
      builder: (context) => SelectLoggersDialog(controller: controller),
    );
  }
}
