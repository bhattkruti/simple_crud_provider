import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crud_provider/student_provider.dart';
import 'package:simple_crud_provider/student_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => StudentProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StudentScreen(),
    );
  }
}
