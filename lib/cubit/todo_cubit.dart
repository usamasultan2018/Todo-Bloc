import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/model/todo_model.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  TodoCubit() : super([]);

  void addTodoToList(String title) {
    final todo = TodoModel(name: title, createdAt: DateTime.now(),);
    state.add(todo);
    emit([...state]);
  }
  void deleteTodo(int index) {
    state.removeAt(index);
    emit([...state]);
  }
}
