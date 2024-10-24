import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/data/model/todo.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<ToDoBloc, ToDoState>(
          builder: (context, state) {
            if (state is ToDoInitial) {
              return buildInitail();
            } else if (state is ToDoListView) {
              return toDolistReady(context, state.items);
            }
            return const Text('Problem');
          },
        ),
      ),
    );
  }

  Widget buildInitail() {
    return Center(
      child: BuildInitail(),
    );
  }

  Column toDolistReady(BuildContext context, List<ToDoModel> items) {
    return Column(
      children: [
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.title),
            );
          },
        )
      ],
    );
  }
}

class BuildInitail extends StatelessWidget {
  const BuildInitail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const SizedBox(
        height: 30,
      ),
      Container(
        margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          )
        ]),
        child: TextField(
          onSubmitted: (value) => submitToDo(context, value),
          decoration: InputDecoration(
            hintText: 'Clean room',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            suffixIcon: const Icon(Icons.add),
          ),
        ),
      ),
    ]));
  }
}

void submitToDo(BuildContext contex, String value) {
  final toDoBloc = BlocProvider.of<ToDoBloc>(contex);
  toDoBloc.add(AddToDo(value, 'test'));
}
