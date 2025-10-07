import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:placement/data/repository/homepage_repository/test_repository.dart';
import 'package:placement/models/home_models/test_models.dart';

class MockTestController extends GetxController {
  var questions = <Question>[].obs;
  var currentIndex = 0.obs;
  var selectedOption = (-1).obs;
  var isAnswered = false.obs;
  var score = 0.obs;
  var timer = 60.obs;
  var testCompleted = false.obs;
  var hasError = false.obs;

  Timer? _questionTimer;
  final AIRepositoryTest repository = AIRepositoryTest();

  @override
  void onClose() {
    _questionTimer?.cancel();
    super.onClose();
  }

  /// Fetch question dynamically
  Future<void> fetchNextQuestion(String type) async {
    if (testCompleted.value) return;

    hasError.value = false;

    try {
      final prompt =
          "Generate 1 $type mock question in JSON format with 4 options and correct answer index.";

      final response = await repository.fetchTestQuestion(prompt);

      final start = response.indexOf('{');
      final end = response.lastIndexOf('}');
      if (start != -1 && end != -1) {
        String jsonString = response.substring(start, end + 1);
        jsonString = jsonString.replaceAll('```', '').trim();

        try {
          final questionMap = jsonDecode(jsonString) as Map<String, dynamic>;
          final newQuestion = Question.fromJson(questionMap);
          questions.add(newQuestion);
        } catch (e) {
          print("JSON parse failed: $e");
          hasError.value = true;
        }
      } else {
        print("No JSON found in API response");
        hasError.value = true;
      }
    } catch (e) {
      print("Error fetching question: $e");
      hasError.value = true;
    }
  }

  /// Start test
  Future<void> startTest(String type) async {
    currentIndex.value = 0;
    score.value = 0;
    selectedOption.value = -1;
    isAnswered.value = false;
    timer.value = 100;
    testCompleted.value = false;
    hasError.value = false;
    questions.clear();

    await fetchNextQuestion(type);
    _startTimer();
  }

  /// Handle option selection
  void selectOption(int index, String type) async {
    if (isAnswered.value || testCompleted.value) return;

    selectedOption.value = index;
    isAnswered.value = true;

    if (index == questions[currentIndex.value].correctAnswer) {
      score.value += 2;
      timer.value += 8;
    } else {
      timer.value -= 2;
      if (timer.value < 0) timer.value = 0;
    }

    Future.delayed(const Duration(seconds: 1), () async {
      if (testCompleted.value) return;

      if (currentIndex.value < questions.length - 1) {
        currentIndex.value++;
        selectedOption.value = -1;
        isAnswered.value = false;
        _startTimer();
      } else {
        await fetchNextQuestion(type);
        currentIndex.value++;
        selectedOption.value = -1;
        isAnswered.value = false;
        _startTimer();
      }
    });
  }

  /// Timer
  void _startTimer() {
    _questionTimer?.cancel();
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        t.cancel();
        testCompleted.value = true;
      }
    });
  }

  /// Retry fetch
  void retry(String type) async {
    await fetchNextQuestion(type);
    if (!hasError.value && questions.isNotEmpty && !isAnswered.value) {
      _startTimer();
    }
  }
}
