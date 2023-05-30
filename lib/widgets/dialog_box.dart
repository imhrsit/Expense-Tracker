import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';

Future<void> ErrorDialog(BuildContext context, String errorMessage) async {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Error",
    style: const AlertStyle(
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    closeIcon: const SizedBox(),
    buttons: [
      DialogButton(
        onPressed: () => Navigator.of(context).pop(),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          "OK",
          style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.backgroundColor),
        ),
      ),
    ],
    content: Text(
      errorMessage,
      style: const TextStyle(fontSize: 14),
    ),
  ).show();
}
