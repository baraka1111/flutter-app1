class TodoItem {
  final String id;
  final String title;
  final String? description;
  bool isDone;

  TodoItem({
    required this.id,
    required this.title,
    this.description,
    this.isDone = false,
  });

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}