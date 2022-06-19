import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const AppButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return ElevatedButton(
        onPressed: onPressed,
        child: child,
      );
    }
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: child,
    );
  }
}
