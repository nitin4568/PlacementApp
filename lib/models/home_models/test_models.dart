class Question {
  String question;
  List<String> options;
  int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {

    final opts = List<String>.from(json['options'] ?? []);
    // Get correct answer index from JSON
    final correctIndex = json['correctAnswer'] ?? 0;


    final shuffled = List<String>.from(opts);
    shuffled.shuffle();


    final newCorrectIndex = shuffled.indexOf(opts[correctIndex]);

    return Question(
      question: json['question'] ?? '',
      options: shuffled,
      correctAnswer: newCorrectIndex,
    );
  }
}
