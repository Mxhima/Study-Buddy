class Task {
  final String id;
  final String title;
  late final bool completed;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
  });

  void toggleCompleted() {
    completed = !completed;
  }

  factory Task.fromMap(Map<String, dynamic> data, String documentId) {
    return Task(
      id: documentId,
      title: data['title'],
      completed: data['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
