class Task {
  final String title;
  final bool completed;

  const Task({
    required this.title,
    this.completed = false,
  });

  Task copyWith({
    String? title,
    bool? completed,
  }) {
    return Task(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}