import 'package:flutter/material.dart';
import 'package:todo/screens/todoList.dart';

void main() {
  runApp(const MyApp());
}


final themeMode = ValueNotifier(1);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
         builder: (context, value, g) {
        return   MaterialApp(
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.values.toList()[value as int],
        debugShowCheckedModeBanner: false,
        home:Homepage(),//SplashScreen(),
        );
        },
         valueListenable: themeMode,
      );
    //));
  }
}