class UpcomingEvent {
  final String title;
  final String date;
  final String link;

  UpcomingEvent({
    required this.title,
    required this.date,
    required this.link,
  });

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) {
    return UpcomingEvent(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      link: json['link'] ?? '',
    );
  }
}
