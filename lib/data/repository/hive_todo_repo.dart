import 'package:hive/hive.dart';
import 'package:todo_bloc/data/models/hive_todo.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class HiveRepo implements TodoRepo {
  final Box<HiveTodo> hiveBox; // Hive box to store HiveTodo
  HiveRepo(this.hiveBox);

  @override
  Future<void> addTodos(Todo addTodos) async {
    final hiveTodo = HiveTodo.fromDomain(addTodos);
    await hiveBox.put(hiveTodo.id, hiveTodo); // Put the Todo into the Hive box
  }

  @override
  Future<void> deleteTodos(Todo todo) async {
    await hiveBox.delete(todo.id); // Delete the Todo by id
  }

  @override
  Future<List<Todo>> getTodo() async {
    final todos =
        hiveBox.values.toList(); // Get all the values from the Hive box
    var allTodo = todos
        .map((hiveTodo) => hiveTodo.toDomain())
        .toList(); // Map to domain models
    return allTodo;
  }

  @override
  Future<void> updateTodos(Todo newTodos) async {
    final hiveTodo = HiveTodo.fromDomain(newTodos);
    await hiveBox.put(hiveTodo.id, hiveTodo); // Update the Todo in the Hive box
  }
}
