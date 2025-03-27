import 'package:flutter/material.dart';
import 'package:test_app/model/todo_model.dart';
import '../db/todo_db.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  // Load todos from database
  Future<void> loadTodos() async {
    _todos = await TodoDB.getTodos();
    notifyListeners();
  }

  // Add a new todo
  Future<void> addTodo(String title, String description) async {
    Todo newTodo = Todo(title: title, description: description);
    await TodoDB.insertTodo(newTodo);
    await loadTodos();
  }

  // Update an existing todo
  Future<void> updateTodo(Todo todo, String newTitle, String newDescription) async {
    todo.title = newTitle;
    todo.description = newDescription;
    await TodoDB.updateTodo(todo);
    await loadTodos();
  }

  // Toggle completion status
  Future<void> toggleTodoStatus(Todo todo) async {
    todo.isDone = !todo.isDone;
    await TodoDB.updateTodo(todo);
    await loadTodos();
  }

  // Delete a todo
  Future<void> deleteTodo(int id) async {
    await TodoDB.deleteTodo(id);
    await loadTodos();
  }
}
