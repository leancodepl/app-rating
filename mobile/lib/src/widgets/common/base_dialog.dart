import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({super.key, required this.child, this.backgroundColor});

  final Widget child;

  /// The dialog's background color. Defaults to
  /// [DialogThemeData.backgroundColor].
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}
