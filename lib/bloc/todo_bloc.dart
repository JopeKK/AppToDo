import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/data/model/todo.dart';
import 'package:to_do_app/data/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final Repo repo;

  ToDoBloc(this.repo) : super(const ToDoInitial());

  @override
  Stream<ToDoState> mapEventToState(
    ToDoEvent event,
  ) async* {
    if (event is AddToDo) {
      final List<ToDoModel> items = await repo.getItems();
      items.add(ToDoModel(
        title: event.title,
        description: event.description,
      ));
      await repo.saveItems(items);
      yield ToDoListView(items);
    } else if (event is DoneToDo) {
      final List<ToDoModel> items = await repo.getItems();
      yield ToDoListView(items);
    }
  }
}
