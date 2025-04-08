import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/todo_provider.dart'; // Ensure this path is correct
import 'todo_list_screen.dart';
import 'todo_model.dart'; // Ensure this path is correct

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(builder: (context, provider, child) {
        if (provider.todos.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No tasks yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  'Tap the + button to add one',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: provider.todos.length,
          itemBuilder: (context, index) {
            final todo = provider.todos[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 2,
              child: ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    color: todo.isDone ? Colors.grey : null,
                  ),
                ),
                subtitle: todo.description?.isNotEmpty ?? false
                    ? Text(todo.description!)
                    : null,
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => provider.toggleTodoStatus(todo),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _navigateToEditScreen(context, todo),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteTask(context, todo.id as int);  // Trigger delete
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddScreen(context),
      ),
    );
  }

  void _navigateToAddScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoListScreen(
          onSave: (newTodo) {
            context.read<TodoProvider>().addTodo(newTodo);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, TodoItem todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoListScreen(
          todo: todo,
          onSave: (updatedTodo) {
            context.read<TodoProvider>().updateTodo(updatedTodo);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  // Function to handle task deletion
  void _deleteTask(BuildContext context, int todoId) {
    // Show confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              // Delete the task
              context.read<TodoProvider>().deleteTodo(todoId);
              Navigator.pop(context);  // Close the dialog
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Close the dialog without deleting
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
