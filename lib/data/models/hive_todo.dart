import 'package:hive/hive.dart';
import 'package:todo_bloc/domain/models/todo.dart';

part 'hive_todo.g.dart'; // For the generated adapter

@HiveType(typeId: 0) // Assign a unique typeId
class HiveTodo extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool isCompleted;

  HiveTodo({
    required this.id,
    required this.text,
    required this.isCompleted,
  });

  // Convert HiveTodo to Domain model
  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  // Convert Domain model to HiveTodo
  static HiveTodo fromDomain(Todo todo) {
    return HiveTodo(
      id: todo.id,
      text: todo.text,
      isCompleted: todo.isCompleted,
    );
  }
}
