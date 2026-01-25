import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';

class AvailableCommandsWidget extends StatelessWidget {
  Map<String, String> commands;
  AvailableCommandsWidget({super.key, required this.commands});

  final width = screenW;
  List<Widget> commandWidgets = [];
  @override
  Widget build(BuildContext context) {
    commands.forEach((command, desc) {
      commandWidgets.add(CommandWidget(command: command, description: desc));
    });
    return Container(
      width: width,
      padding: EdgeInsets.all(padding),
      child: Wrap(children: commandWidgets),
    );
  }
}
