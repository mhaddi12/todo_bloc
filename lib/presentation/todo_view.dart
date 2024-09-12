import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo/todo_cubit.dart';
import 'package:todo_bloc/domain/models/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    TextEditingController textEditingController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Todo"),
            content: TextField(
              controller: textEditingController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    todoCubit.addTodo(textEditingController.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Add")),
            ],
          );
        });
  }

  

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(builder: (context, state) {
        return SafeArea(
            child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final showTodo = state[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Checkbox(
                          value: showTodo.isCompleted,
                          onChanged: (value) {
                            todoCubit.updateToggleTodo(showTodo);
                          }),
                      title: Text(
                        showTodo.text,
                        style: TextStyle(
                          decoration: showTodo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration
                                  .none, // Apply strikethrough if completed
                          color: showTodo.isCompleted
                              ? Colors.grey
                              : Colors
                                  .black, // Change color to grey if completed
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            todoCubit.deleteTodo(showTodo);
                          },
                          icon: const Icon(Icons.cancel)),
                    ),
                  );
                }));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
