import '../models/todo.dart';

abstract class TodoRepo {
  //get todo
  Future<List<Todo>> getTodo();

  //update todo
  Future<void> updateTodos(Todo newTodos);

  // delete todo
  Future<void> deleteTodos(Todo todo);

  // add todo
  Future<void> addTodos(Todo addTodos);
}
