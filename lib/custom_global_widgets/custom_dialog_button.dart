import 'package:flutter/material.dart';

class CustomDialogButton extends StatelessWidget {
  final String text;
  final Color primaryColor;
  final Color secondaryColor;
  final double fontSize;
  final bool bold;
  final void Function() onPressed;

  const CustomDialogButton(
      {super.key,
      required this.text,
      required this.primaryColor,
      required this.secondaryColor,
      required this.onPressed,
      this.fontSize = 14,
      this.bold = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStatePropertyAll<Color>(primaryColor),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return secondaryColor;
            }
            return null;
          },
        ),
      ),
      onPressed: onPressed,
      child: Center(
          child: Text(text,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal))),
    );
  }
}
