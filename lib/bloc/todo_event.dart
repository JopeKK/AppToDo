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
  final String title;

  const DoneToDo(this.title);

  @override
  List<Object> get props => [title];
}

class RemoveToDo extends ToDoEvent {
  final String title;

  const RemoveToDo(this.title);

  @override
  List<Object> get props => [title];
}

class RemoveAll extends ToDoEvent {
  const RemoveAll();

  @override
  List<Object> get props => [];
}
