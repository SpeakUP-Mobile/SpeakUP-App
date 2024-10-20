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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      // recordingsButton(context),
                      // const SizedBox(height: 5),
                      // backButton(context),
                      // const SizedBox(height: 15),
                      // resultsOverview(context),
                      // const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: controller.questions.length + 4,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    recordingsButton(context),
                                    const SizedBox(height: 5),
                                  ],
                                );
                              } else if (index == 1) {
                                return Column(
                                  children: [
                                    backButton(context),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              } else if (index == 2) {
                                return Column(
                                  children: [
                                    resultsOverview(context),
                                    const SizedBox(height: 25),
                                  ],
                                );
                              } else if (index ==
                                  controller.questions.length + 3) {
                                return Column(
                                  children: [
                                    backButton(context),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    questionResult(context, index - 3),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              }
                            }),
                      ),
                    ]),
              ),
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
        onTap: () => controller.viewRecordings());
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
        onTap: () => controller.backToHome());
  }

  Container resultsOverview(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 30,
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(69, 158, 158, 158),
                spreadRadius: 2,
                blurRadius: 3,
              )
            ]),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Spacer(),
            SizedBox(
              width: 230,
              child: Text(controller.recordingName,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Text(controller.dateTime, //'18:35 on April 1st, 2022'
                  style: const TextStyle(
                    fontSize: 14,
                  )),
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
        width: 80,
        height: 80,
        child: CircularProgressIndicator(
          value: 0.96,
          color: Color(0xFF8F00FF),
          strokeWidth: 6,
        ),
      ),
      Positioned(
          left: 12,
          top: 21,
          child: Row(
            children: [
              Text('96',
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF8F00FF),
                      fontWeight: FontWeight.bold)),
              Text('%',
                  style: TextStyle(fontSize: 28, color: Color(0xFF8F00FF)))
            ],
          ))
    ]);
  }

  Container questionResult(BuildContext context, int index) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(69, 158, 158, 158),
                spreadRadius: 2,
                blurRadius: 3,
              )
            ]),
        child: Column(
          children: [
            Text('Question ${index + 1}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            emotionScore(context, 'Positive Emotions',
                controller.questionResults[index][0]),
            const SizedBox(height: 5),
            emotionScore(context, 'Negative Emotions',
                controller.questionResults[index][1]),
            const SizedBox(height: 5),
            emotionScore(context, 'Use of Filler Words',
                controller.questionResults[index][2]),
            const SizedBox(height: 15),
            Text(controller.llamaResults[index],
                style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
          ],
        ));
  }

  Column emotionScore(BuildContext context, String title, int score) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          const InkWell(
              child: Icon(Icons.info,
                  color: Color.fromARGB(255, 153, 153, 153), size: 18))
        ],
      ),
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
                  backgroundColor: const Color(0xFFD9D9D9),
                  color: const Color(0xFF8F00FF)))
        ],
      ),
    ]);
  }
}
