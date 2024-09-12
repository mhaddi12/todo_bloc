import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/data/models/hive_todo.dart';

import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/presentation/todo_page.dart';

import 'data/repository/hive_todo_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and the Todo box
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);

  // Register the Hive adapter for HiveTodo
  Hive.registerAdapter(HiveTodoAdapter());

  // Open the Hive box for HiveTodo
  final todoBox = await Hive.openBox<HiveTodo>('todoBox');

  // Create Hive repository instance
  final hiveTodoRepo = HiveRepo(todoBox);

  runApp(MyApp(
    todoRepo: hiveTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TodoPage(todoRepo: todoRepo),
      ),
    );
  }
}
