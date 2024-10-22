import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'interview_results_controller.dart';

class InterviewResults extends GetView<InterviewResultsController> {
  const InterviewResults({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InterviewResultsController());
    //ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 117,
            surfaceTintColor: Colors.white,
            elevation: 5,
            leading: BackButton(
              onPressed: () => {
                Get.back(),
                Get.back(),
              },
            ),
            shadowColor: const Color.fromARGB(38, 0, 0, 0),
            title: GradientText(
              'Results',
              textAlign: TextAlign.center,
              colors: const [Color(0xff8710d0), Color(0xff8710d0)],
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
              bottom: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
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
                                  return const Column(
                                    children: [
                                      SizedBox(height: 10),
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
                                } else {
                                  return Column(
                                    children: [
                                      questionResult(context, index - 3),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }
                                return null;
                              }),
                        ),
                      ]),
                ),
              ))),
    );
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

/*
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
*/

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
    return Stack(children: [
      SizedBox(
        width: 80,
        height: 80,
        child: CircularProgressIndicator(
          value: controller.score / 100,
          color: const Color(0xFF8F00FF),
          strokeWidth: 6,
        ),
      ),
      Positioned(
          left: 12,
          top: 21,
          child: Row(
            children: [
              Text('${controller.score}',
                  style: const TextStyle(
                      fontSize: 28,
                      color: Color(0xFF8F00FF),
                      fontWeight: FontWeight.bold)),
              const Text('%',
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
            emotionScore(context, 1, 'Positive Emotions',
                controller.questionResults[index][0]),
            const SizedBox(height: 5),
            emotionScore(context, 2, 'Negative Emotions',
                controller.questionResults[index][1]),
            const SizedBox(height: 5),
            emotionScore(context, 3, 'Use of Filler Words',
                controller.questionResults[index][2],
                total: controller.questionResults[index][3]),
            const SizedBox(height: 15),
            Text(controller.llamaResults[index],
                style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
          ],
        ));
  }

  Column emotionScore(BuildContext context, int number, String title, int score,
      {int total = 100}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          // const InkWell(
          //     child: Icon(Icons.info,
          //         color: Color.fromARGB(255, 153, 153, 153), size: 18))
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            child: MenuAnchor(
              menuChildren: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        number == 1
                            ? 'A higher subscore in the positive emotions category increases your overall score. The postive emotions subscore is calculated by averaging your scores for the following emotions: Calmness, Concentration, Contemplation, Contentment, Determination, Excitement, Interest, Joy, Realization, Surprise (positive), and Triumph.'
                            : number == 2
                                ? 'A higher subscore in the negative emotions category decreases your overall score. The negative emotions subscore is calculated by averaging your scores for the following emotions: Anger, Anxiety, Awkwardness, Boredom, Confusion, Contempt, Distress, Doubt, Embarrassment, Fear, Pride, Surprise (negative), and Tiredness.'
                                : number == 3
                                    ? 'A higher subscore in the use of filler words category decreases your overall score. The filler words subscore is calculated based on the ratio of filler words used to total words used. Examples of filler words include: Ah, Aha, Argh, Eek, Eww, Gasp, Groan, Grunt, Ha, Hmm,Huh, Mhm, Mmm, Oh, Ooh, Ooph, Pff, Phew, Sigh, Tsk, Ugh, Uh, Umm, Whew, Yawn, and Yuck.'
                                    : 'Error gathering information',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ),
              ],
              builder: (_, MenuController controller, Widget? child) {
                return InkWell(
                    onTap: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    child: const Icon(Icons.info,
                        color: Color.fromARGB(255, 153, 153, 153), size: 18));
              },
            ),
          ),
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
                  value: score / total,
                  backgroundColor: const Color(0xFFD9D9D9),
                  color: const Color(0xFF8F00FF)))
        ],
      ),
    ]);
  }
}
