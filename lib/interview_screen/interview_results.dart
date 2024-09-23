import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'interview_results_controller.dart';

class InterviewResults extends GetView<InterviewResultsController> {
  const InterviewResults({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InterviewResultsController());
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              const SizedBox(height: 30),
              GradientText(
                'Results',
                textAlign: TextAlign.center,
                colors: const [Color(0xff8710d0), Color(0xffff18be)],
                style:
                    const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text('YOUR SCORE WAS 100 PERCENT!!'),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          height: 65,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: const BoxDecoration(color: Colors.blue),
                          child: const Text('View Interview Recording')),
                      onTap: () => controller.viewSourceRecordings()),
                  InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          height: 65,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Text('Back to home')),
                      onTap: () => controller.backToHome()),
                ],
              )
            ])));
  }
}
