import 'package:flutter/material.dart';

class ThirdPartyLoginButton extends StatelessWidget {
  final String image;

  const ThirdPartyLoginButton({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.height * 0.06,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Image(image: AssetImage(image))));
  }
}
