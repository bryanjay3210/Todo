import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils/toast.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState(todoList: [], isLoading: false));

  List<Todo> todo = [];

  Future<void> initializeCubit() async {
    /// Displaying To Do List
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isLoading: false, todoList: todo));
  }
  /// Function for adding To Do
  void addTodo(BuildContext context, TextEditingController textFieldController){
    emit(state.copyWith(isLoading: true));
    todo.add(Todo(todo: textFieldController.text, date: DateTime.now()));
    Navigator.pop(context);
    emit(state.copyWith(isLoading: false));
    showToast('Successfully Added!');
  }
  /// Function for deleting To Do
  void deleteTodo(BuildContext context, int index){
    emit(state.copyWith(isLoading: true));
    todo.removeAt(index);
    emit(state.copyWith(isLoading: false));
    showToast('Deleted Successfully!');
  }
  /// Function for editing To Do
  void editTodo(BuildContext context, String oldTask, String task){
    emit(state.copyWith(isLoading: true));
    todo.firstWhere((element) => element.todo == oldTask).todo = task;
    Navigator.pop(context);
    emit(state.copyWith(isLoading: false));
    showToast('Saved Successfully!');
  }
}
