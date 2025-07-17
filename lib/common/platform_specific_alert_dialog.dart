import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSpecificAlertDialog {
  ///Will show a platform (iOS or Android) specific
  /// Alert Dialog box
  static Future show({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget> actions = const [],
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: actions.isNotEmpty
                    ? actions
                    : [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Okay'),
                        ),
                      ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: actions.isNotEmpty
                    ? actions
                    : [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Okay'),
                        ),
                      ],
              );
      },
    );
  }
}
