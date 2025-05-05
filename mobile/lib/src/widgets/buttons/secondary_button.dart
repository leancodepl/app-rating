import 'package:flutter/material.dart';
import 'package:leancode_app_rating/src/widgets/buttons/button.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      label: label,
      textColor: const Color(0xFF7E17E5),
      backgroundColor: const Color(0xFFF2E8FD),
    );
  }
}
