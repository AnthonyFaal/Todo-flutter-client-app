
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Mytodo.dart';

Future<List<MyTodo>> fetchTodo() async {
  final response =
      await http.get(Uri.parse('https://todo-liard-phi.vercel.app/api/todo'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> tasksJson = jsonResponse['data'];

    return tasksJson.map<MyTodo>((json) => MyTodo.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load tasks');
  }
}


Future<void> createTodo(String title, String description) async {
  try {
    final data = {
      'title': title,
      'description': description,
    };

    final response = await http.post(
      Uri.parse('https://todo-liard-phi.vercel.app/api/todo'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

  if (response.statusCode == 200 || response.statusCode == 201) {
  print('Todo created successfully');
} else {
  print('Failed to create todo. Status code: ${response.statusCode}');
  print('Response body: ${response.body}');
  throw Exception('Failed to create todo');
}
  } catch (error) {
    print('Error creating todo: $error');
    throw Exception('Error creating todo: $error');
  }
}

Future<void> updateTodoFunction(
MyTodo todo, String newTitle, String newDescription) async {
try {
final data = {
'title': newTitle,
'description': newDescription,
};

final response = await http.put(
  Uri.parse('https://todo-liard-phi.vercel.app/api/todo/${todo.id}'),
  body: json.encode(data),
  headers: {'Content-Type': 'application/json'},
);

if (response.statusCode == 200) {
  print('Todo updated successfully');
} else {
  print('Failed to update todo. Status code: ${response.statusCode}');
  print('Response body: ${response.body}');
  throw Exception('Failed to update todo');
}
} catch (error) {
print('Error updating todo: $error');
throw Exception('Error updating todo: $error');
}
}

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('https://todo-liard-phi.vercel.app/api/todo/$id'));

    if (response.statusCode == 200) {
      print('Todo deleted successfully');
     // Refresh the todo list after deletion
    } else {
      print('Failed to delete todo. Status code: ${response.statusCode}');
      throw Exception('Failed to delete todo');
    }
  }