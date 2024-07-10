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
      child: Center(
        child: Text(text),
      ),
    );
  }
}
