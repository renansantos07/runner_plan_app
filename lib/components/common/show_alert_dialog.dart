import 'package:flutter/material.dart';

class ShowAlertDialog {
  final BuildContext context;

  ShowAlertDialog.of(this.context);

  show({title = "Ops..", message, actions}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      ),
    );
  }
}
