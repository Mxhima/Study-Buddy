class CalendarEvent {
  final DateTime date;
  final String title;
  final String description;

  CalendarEvent({
    required this.date,
    required this.title,
    required this.description,
  });

  CalendarEvent copyWith({
    DateTime? date,
    String? title,
    String? description,
  }) {
    return CalendarEvent(
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
