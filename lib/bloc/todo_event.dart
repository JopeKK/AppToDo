part of 'todo_bloc.dart';

/*
- zmiana stanu
- dodanie zadania
*/

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class AddToDo extends ToDoEvent {
  final String title;
  final String description;

  const AddToDo(this.title, this.description);

  @override
  List<Object> get props => [title, description];
}

class DoneToDo extends ToDoEvent {
  const DoneToDo();

  @override
  List<Object> get props => [];
}
