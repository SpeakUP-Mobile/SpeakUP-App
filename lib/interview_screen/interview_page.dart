import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InterviewPage extends StatelessWidget {
  const InterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
                onTap: () => Get.back(), child: const Icon(Icons.arrow_back))),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: GradientText(
                'Interview',
                colors: const [Color(0xff8710D0), Color(0xffFF18BE)],
                style: const TextStyle(fontSize: 48),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(color: Colors.grey),
                child: const Text('Placeholder for video')),
          ],
        ));
  }
}
