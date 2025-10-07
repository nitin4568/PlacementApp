class Lecture {
  final String title;
  final String lecturer;
  final String details;
  final String youtubeLink;

  Lecture({
    required this.title,
    required this.lecturer,
    required this.details,
    required this.youtubeLink,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      title: json['title'] ?? '',
      lecturer: json['lecturer'] ?? '',
      details: json['details'] ?? '',
      youtubeLink: json['youtubeLink'] ?? '',
    );
  }
}
