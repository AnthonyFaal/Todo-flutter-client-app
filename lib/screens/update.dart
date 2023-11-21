import 'package:flutter/material.dart';
import '../models/Mytodo.dart';
import '../models/apiCrud.dart';

class UpdateTodo extends StatefulWidget {
  final MyTodo todo;

  const UpdateTodo({required this.todo});

  @override
  _UpdateTodoState createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Update Todo"))),
      body: buildUpdateTodoForm(),
    );
  }

  Widget buildUpdateTodoForm() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        TextField(
          decoration: InputDecoration(hintText: 'Title'),
          controller: titleController,
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Description'),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
          controller: descriptionController,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => updateTodo(),
          child: Text('Update'),
        ),
      ],
    );
  }

  Future<void> updateTodo() async {
    try {
      await updateTodoFunction(
        widget.todo,
        titleController.text,
        descriptionController.text,
      );
      print('Todo updated!');
      Navigator.pop(context); // Navigate back to the previous screen (Homepage)
    } catch (error) {
      print('Error updating todo: $error');
      // Optionally, you can show an error message to the user
    }
  }
}