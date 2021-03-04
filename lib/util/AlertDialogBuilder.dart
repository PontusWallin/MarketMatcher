import 'package:flutter/material.dart';

class AlertDialogBuilder {

  static AlertDialog createDialog({String title, String content, BuildContext context}) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }

  static AlertDialog createErrorDialog({String title, Exception exception, BuildContext context}) {
    return createDialog(title: title, content: exception.toString(), context: context);
  }

}