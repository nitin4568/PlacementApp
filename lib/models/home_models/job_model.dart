class Job {
  final String company;
  final String title;
  final String applyLink;
  final String deadline;

  Job({
    required this.company,
    required this.title,
    required this.applyLink,
    required this.deadline,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      company: json['company'] ?? 'Unknown Company',
      title: json['title'] ?? 'Job Title',
      // applyLink: json['applyLink'] ?? json['apply_link'] ?? '',
      deadline: json['deadline'] ?? '',
      applyLink: json['applyLink'] ?? '',
    );
  }
}
