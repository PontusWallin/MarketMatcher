import 'package:flutter/material.dart';

class AlertDialogBuilder {

  static AlertDialog createDialog({String title, String content, BuildContext context}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        barrierDismissible: true
    );
  }

  static void createErrorDialog({String title, dynamic exception, BuildContext context}) {
        AlertDialogBuilder.createDialog(title: "Error",content: exception.toString(), context: context);
  }
}