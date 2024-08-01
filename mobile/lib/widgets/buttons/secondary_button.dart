import 'package:app_rating/widgets/buttons/button.dart';
import 'package:flutter/material.dart';

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
