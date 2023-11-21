import 'package:flutter/material.dart';

import '../models/apiCrud.dart';
// Import the screen where you want to navigate after successful add

class AddTodo extends StatefulWidget {
 

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Add Todo"))),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                  onPressed: () => _addTodo(
                      titleController.text, descriptionController.text),
                  child: Text('Submit'),
                ),
              ],
            ),
    );
  }

  Future<void> _addTodo(String title, String description) async {
    setState(() {
      isLoading = true;
    });

    try {
      await createTodo(title, description);
      Navigator.pop(context);
     
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to add todo: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}