import 'package:flutter/material.dart';
import 'package:time_management_ai/constants/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Color? backgroundColor;
  const ButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.style,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor ?? AppColors.indigo,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}
