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
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    GradientText(
                      'Results',
                      textAlign: TextAlign.center,
                      colors: const [Color(0xff8710d0), Color(0xffff18be)],
                      style: const TextStyle(
                          fontSize: 56, fontWeight: FontWeight.bold),
                    ),
                    recordingsButton(context),
                    const SizedBox(height: 5),
                    backButton(context),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                        child: Column(children: [
                      resultsOverview(context),
                      const SizedBox(height: 15),
                      questionResult(context),
                    ])),
                    const Spacer(),
                  ]),
            )));
  }

  InkWell recordingsButton(BuildContext context) {
    return InkWell(
        child: Container(
            alignment: Alignment.center,
            height: 40,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              gradient: LinearGradient(
                  colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)]),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View Interview Recordings',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white)
              ],
            )),
        onTap: () => print('View Recordings'));
  }

  InkWell backButton(BuildContext context) {
    return InkWell(
        child: Container(
            alignment: Alignment.center,
            height: 40,
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              gradient: LinearGradient(
                  colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)]),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back, color: Colors.white),
                SizedBox(width: 10),
                Text('Exit',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            )),
        onTap: () => exitResults());
  }

  void exitResults() {
    Get.back();
    Get.back();
    Get.back();
  }

  Container resultsOverview(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 30,
        height: 170,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 2.5,
              )
            ]),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Spacer(),
            const Text('Recording 3',
                style: TextStyle(
                  fontSize: 22,
                )),
            const Text('18:35 on April 1st, 2022',
                style: TextStyle(
                  fontSize: 14,
                )),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)]),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
                  ]),
              child: const Text("Interview",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
          ]),
          const Spacer(),
          circularResults()
        ]));
  }

  Stack circularResults() {
    return const Stack(children: [
      SizedBox(
        width: 125,
        height: 125,
        child: CircularProgressIndicator(
          value: 0.96,
          color: Color(0xFF8F00FF),
          strokeWidth: 6,
        ),
      ),
      Positioned(
          left: 16,
          top: 25,
          child: Row(
            children: [
              Text('96',
                  style: TextStyle(
                      fontSize: 52,
                      color: Color(0xFF8F00FF),
                      fontWeight: FontWeight.bold)),
              Text('%',
                  style: TextStyle(fontSize: 32, color: Color(0xFF8F00FF)))
            ],
          ))
    ]);
  }

  Container questionResult(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
            ]),
        child: Column(
          children: [
            const Text('Question 1', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 5),
            emotionScore(context, 1, 68),
            const SizedBox(height: 5),
            emotionScore(context, 2, 95),
            const SizedBox(height: 5),
            emotionScore(context, 3, 42)
          ],
        ));
  }

  Column emotionScore(BuildContext context, int number, int score) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Emotion $number',
          style: const TextStyle(fontWeight: FontWeight.bold)),
      Row(
        children: [
          Text('$score',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8F00FF),
                  fontSize: 18)),
          const SizedBox(width: 10),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  minHeight: 18,
                  value: score / 100,
                  backgroundColor: Colors.grey,
                  color: const Color(0xFF8F00FF)))
        ],
      )
    ]);
  }
}
