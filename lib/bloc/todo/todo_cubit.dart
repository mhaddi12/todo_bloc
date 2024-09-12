import 'package:flutter/src/widgets/safe_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/models/hive_todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

import '../../domain/models/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoReop;
  TodoCubit(this.todoReop) : super([]) {
    loadTodo();
  }

  void loadTodo() async {
    final getTodo = await todoReop.getTodo();
    emit(getTodo);
  }

  void addTodo(String text) async {
    final todo = Todo(id: DateTime.now().millisecond, text: text);

    await todoReop.addTodos(todo);

    loadTodo();
  }

  void deleteTodo(Todo todo) async {
    await todoReop.deleteTodos(todo);
    loadTodo();
  }

  void updateToggleTodo(Todo todo) async {
    final updateTodo = todo.toggleComplete();

    await todoReop.updateTodos(updateTodo);

    loadTodo();
  }
}
