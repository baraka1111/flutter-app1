import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/todo_model.dart';
import 'package:test_app/provider/todo_provider.dart';

class AddTaskScreen extends StatefulWidget {
  final Todo? todo;
  AddTaskScreen({this.todo});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Todo' : 'Add Todo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            SizedBox(height: 10),
            TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final description = _descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  final provider = Provider.of<TodoProvider>(context, listen: false);

                  if (isEditing) {
                    provider.updateTodo(widget.todo!, title, description);
                  } else {
                    provider.addTodo(title, description);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}