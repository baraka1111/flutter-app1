import 'package:flutter/material.dart';
import 'todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  void addTodo(TodoItem todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(TodoItem updatedTodo) {
    int index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
      notifyListeners();
    }
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodoStatus(TodoItem todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }
}
