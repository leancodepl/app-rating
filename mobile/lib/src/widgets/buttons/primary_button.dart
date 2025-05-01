import 'package:flutter/material.dart';
import 'package:leancode_app_rating/src/widgets/buttons/button.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      label: label,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF7E17E5),
    );
  }
}
