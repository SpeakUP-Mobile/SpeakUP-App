import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  final String text;

  const CustomLoginButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 250,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
          ]),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.grey[200];
              }
              return null;
            },
          ),
        ),
        child: Center(child: Text(text)),
        onPressed: () => true,
      ),
    );
  }
}
