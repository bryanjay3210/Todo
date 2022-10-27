import 'package:flutter/material.dart';

Future<void> genericDialog (BuildContext context,{required String title, required Widget widget, required String buttonText, required VoidCallback function}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: widget,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            onPressed: function,
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}

