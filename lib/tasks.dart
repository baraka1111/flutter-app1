import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/addtask.dart';
import 'package:test_app/provider/todo_provider.dart';

class MyTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              final todo = provider.todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(todo.description),
                trailing: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => provider.toggleTodoStatus(todo),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen(todo: todo)),
                  );
                },
                onLongPress: () => provider.deleteTodo(todo.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
      ),
    );
  }
}
