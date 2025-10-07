class ResumeAnalysis {
  final int atsScore; // 0-100
  final String summary;
  final List<String> recommendations;

  ResumeAnalysis({
    required this.atsScore,
    required this.summary,
    required this.recommendations,
  });

  factory ResumeAnalysis.fromJson(Map<String, dynamic> json) {
    return ResumeAnalysis(
      atsScore: json['atsScore'] ?? 0,
      summary: json['summary'] ?? '',
      recommendations: List<String>.from(json['recommendations'] ?? []),
    );
  }
}
