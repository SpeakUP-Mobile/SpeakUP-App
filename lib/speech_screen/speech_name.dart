import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speech_name_controller.dart';

class SpeechNamePage extends GetView<SpeechNameController> {
  final String videoPath;

  const SpeechNamePage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name this recording',
                    hintText: 'Untitled 1'),
                onChanged: (name) => controller.updateName(name),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                controller.validName.isFalse ? 'Name already exists' : '',
                style: const TextStyle(fontSize: 40, color: Colors.red))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => controller.analyze(videoPath),
                    child: const Text('Analyze')),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => controller.cancel(),
                    child: const Text("Cancel"))
              ],
            )
          ]),
    );
  }
}
