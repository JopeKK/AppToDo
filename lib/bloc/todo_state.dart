part of 'todo_bloc.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();
}

class ToDoInitial extends ToDoState {
  const ToDoInitial();

  @override
  List<Object> get props => [];
}

class ToDoListView extends ToDoState {
  final List<ToDoModel> items;
  const ToDoListView(this.items);

  @override
  List<Object> get props => [];
}
