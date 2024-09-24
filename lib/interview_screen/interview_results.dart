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
              InkWell(
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, color: Colors.white)
                        ],
                      )),
                  onTap: () => print('View Recordings')),
              const SizedBox(height: 15),
              SingleChildScrollView(
                  child: Column(children: [
                resultsOverview(context),
                const SizedBox(height: 30),
                questionResult(context),
              ])),
              const Spacer(),
              temporaryNavigation(context),
            ])));
  }

  Row temporaryNavigation(BuildContext context) {
    return Row(
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
    );
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
        height: 230,
        width: MediaQuery.of(context).size.width - 30,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
            ]));
  }
}
