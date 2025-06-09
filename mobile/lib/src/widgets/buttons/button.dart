import 'package:flutter/material.dart';
import 'package:leancode_app_rating/src/widgets/common/text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8));
    const duration = Duration(milliseconds: 120);

    return AnimatedOpacity(
      duration: duration,
      opacity: onPressed != null ? 1 : 0.5,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPressed,
            customBorder: const RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(label, style: buttonTextStyle(textColor)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
