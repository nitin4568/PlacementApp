import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement/data/repository/homepage_repository/ai_repository.dart';

class AIChatsController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final AIRepository repository = AIRepository();

  var messages = <Map<String, dynamic>>[].obs;
  var isTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    messages.add({
      "sender": "bot",
      "message": "Hi! 👋 I’m Era, your placement assistant. Ask me anything about placements, interviews, or resumes."
    });
  }

  void sendMessage() async {
    final userMessage = textController.text.trim();
    if (userMessage.isEmpty) return;

    messages.add({"sender": "user", "message": userMessage});
    textController.clear();

    isTyping.value = true;
    messages.add({"sender": "bot", "message": "typing..."});

    final botResponse = await repository.getAIResponse(userMessage);

    // Replace "typing..." with actual response
    messages.removeLast();
    messages.add({"sender": "bot", "message": botResponse});
    isTyping.value = false;
  }
}
