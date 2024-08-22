import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'interview_analysis_controller.dart';

class InterviewAnalysis extends GetView<InterviewAnalysisController> {
  const InterviewAnalysis({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
                onTap: () => Get.back(), child: const Icon(Icons.arrow_back))),
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              Center(
                  child: GradientText('Interview #',
                      textAlign: TextAlign.center,
                      colors: const [Color(0xff8710d0), Color(0xffff18be)],
                      style: const TextStyle(
                          fontSize: 58, fontWeight: FontWeight.bold))),
              const SizedBox(height: 30),
            ])));
  }
}
