import 'package:flutter/material.dart';
import '../main.dart';
import '../models/Mytodo.dart';
import '../models/apiCrud.dart';
import 'addTodo.dart';
import 'todoDetails.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<MyTodo>> futureTodo;

  @override
  void initState() {
    super.initState();
    futureTodo = fetchTodo();
  }

  Future<void> _refreshTodoList() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay of 2 seconds
    setState(() {
      futureTodo = fetchTodo();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
        elevation: 0,
        // Light and dark mode
        actions: [
          IconButton(
            icon: Icon(Icons.nightlight_round),
            onPressed: () {
              themeMode.value = themeMode.value == 1 ? 2 : 1;
            },
          )
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          strokeWidth: 2,
          onRefresh: _refreshTodoList,
          child: FutureBuilder<List<MyTodo>>(
            future: futureTodo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoDetails(todo: snapshot.data![index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: Text("${index + 1}"),
                                    ),
                                    Text(
                                      "${snapshot.data![index].title}",
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () => deleteTodo(snapshot.data![index].id),
                                      child: const Icon(Icons.close),
                                    ),
                                  ],
                             ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}