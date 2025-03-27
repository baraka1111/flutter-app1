import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app/model/todo_model.dart';


class TodoDB {
  static Database? _database;

  // Initialize and get the database
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final path = join(await getDatabasesPath(), 'todos.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isDone INTEGER)",
        );
      },
    );
    return _database!;
  }

  // Insert a new todo
  static Future<int> insertTodo(Todo todo) async {
    final db = await getDatabase();
    return db.insert('todos', todo.toMap());
  }

  // Fetch all todos
  static Future<List<Todo>> getTodos() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

  // Update a todo
  static Future<int> updateTodo(Todo todo) async {
    final db = await getDatabase();
    return db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  // Delete a todo
  static Future<int> deleteTodo(int id) async {
    final db = await getDatabase();
    return db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
