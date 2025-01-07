import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/data/model/todo.dart';
import 'package:to_do_app/data/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final Repo repo;

  ToDoBloc(this.repo) : super(const ToDoInitial()) {
    on<AddToDo>(processAddToDo);
    on<DoneToDo>(processDoneToDo);
    on<RemoveToDo>(processRemoveToDo);
    on<RemoveAll>(processRemoveAll);
    on<ContinueOldOne>(processContinueOldOne);
  }

  Future<void> processAddToDo(AddToDo event, Emitter emit) async {
    final List<ToDoModel> items = await repo.getItems();
    items.add(ToDoModel(
      title: event.title,
      description: event.description,
      isDone: false,
    ));
    await repo.saveItems(items);
    emit(ToDoListView(items));
  }

  Future<void> processDoneToDo(DoneToDo event, Emitter emit) async {
    final List<ToDoModel> items = await repo.getItems();
    
    for (var i = 0; i < items.length; i++) {
      if (items[i].title == event.title) {
        //no bo on jest final i co tu zrobic
        //copy with
        items[i] = ToDoModel(
            title: items[i].title,
            description: items[i].description,
            isDone: !items[i].isDone);
        break;
      }
    }
    //mozna tez dodac id albo dopasowowywac title i opis czy inaczej

    await repo.saveItems(items);
    emit(ToDoListView(items));
  }

  Future<void> processRemoveToDo(RemoveToDo event, Emitter emit) async {
    final List<ToDoModel> items = await repo.getItems();

    for (var i = 0; i < items.length; i++) {
      if (items[i].title == event.title) {
        items.removeAt(i);
        break;
      }
    }

    await repo.saveItems(items);
    emit(ToDoListView(items));
  }

  Future<void> processRemoveAll(RemoveAll event, Emitter emit) async {
    final List<ToDoModel> items = await repo.getItems();

    items.clear();

    await repo.saveItems(items);
    emit(ToDoListView(items));
  }

  Future<void> processContinueOldOne(ContinueOldOne event, Emitter emit) async {
    final List<ToDoModel> items = await repo.getItems();

    emit(ToDoListView(items));
  }
}
