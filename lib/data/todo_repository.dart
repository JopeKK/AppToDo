import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/data/model/todo.dart';

abstract class Repo {
  Future<List<ToDoModel>> getItems();
  Future<void> saveItems(List<ToDoModel> items);
}

class TodoRepository implements Repo {
  @override
  Future<List<ToDoModel>> getItems() async {
    final List<ToDoModel> items;

    final SharedPreferences db = await SharedPreferences.getInstance();

    List<String> itemsJson = db.getStringList('items') ?? [];

    items = itemsJson
        .map(
          (item) => ToDoModel.fromJson(json.decode(item)),
        )
        .toList();

    return items;
  }

  @override
  Future<void> saveItems(List<ToDoModel> items) async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();
    db.setStringList('items', readyToSave);
  }
}

// class ExtendedToDo extends TodoRepository{

// }
