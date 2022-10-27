part of 'todo_cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    required this.todoList,
    required this.isLoading,
  });
  final List<Todo> todoList;
  final bool isLoading;
  TodoState copyWith({
    List<Todo>? todoList,
    bool? isLoading
  }){
    return TodoState(todoList: todoList ?? this.todoList, isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [
    todoList,
    isLoading,
  ];
}
