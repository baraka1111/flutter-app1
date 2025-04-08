import 'package:flutter/material.dart';
import 'todo_model.dart';

class TodoListScreen extends StatelessWidget {
  final TodoItem? todo;
  final Function(TodoItem) onSave;

  const TodoListScreen({
    Key? key,
    this.todo,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController =
        TextEditingController(text: todo?.description ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final newTodo = TodoItem(
                  
                  title: titleController.text,
                  description: descriptionController.text.isEmpty
                      ? null
                      : descriptionController.text,
                  isDone: todo?.isDone ?? false, id: '',
                );
                onSave(newTodo);
              },
              child: Text(todo == null ? 'Add Task' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
