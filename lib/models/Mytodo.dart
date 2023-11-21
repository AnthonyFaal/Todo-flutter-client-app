import 'dart:convert';


List< MyTodo> postFromJson(String str) =>
    List< MyTodo>.from(json.decode(str).map((x) =>  MyTodo.fromMap(x)));

class  MyTodo{
  final int id;
 final String title;
 final String description;
 

 MyTodo( {required this.id, required this.title, required this.description});

     factory  MyTodo.fromMap(Map<String, dynamic> json) =>  MyTodo(
id: json['id'],
 title: json['title'],
  description: json['description'],
  
    );
  }

