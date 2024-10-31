import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/data/model/todo.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});
  //flutter clean - do problemow z cocoaPods
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
        scrolledUnderElevation: 3,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<ToDoBloc, ToDoState>(
          //no tutaj czy mamy 1 stan czy jak to powinno byc trzeb sie zastanowic
          builder: (context, state) {
            if (state is ToDoInitial) {
              return buildInitail();
            } else if (state is ToDoListView) {
              //no i jakos dodac to menu ma gorze tu;
              return toDolistReady(context, state.items);
            }
            return const Text('Problem');
          },
        ),
      ),
    );
  }

  Widget buildInitail() {
    return const Center(
      child: BuildInitail(),
    );
  }

  Column toDolistReady(BuildContext context, List<ToDoModel> items) {
    return Column(
      children: [
        const BuildInitail(),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(
                  left: 60,
                  right: 60,
                  top: 5,
                  bottom: 5,
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.11),
                          blurRadius: 80,
                          spreadRadius: 0.0,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => changeDone(context, item.title),
                          icon: item.isDone
                              ? const Icon(Icons.check_box)
                              : const Icon(Icons.check_box_outline_blank)),
                      IconButton(
                          onPressed: () => removeToDo(context, item.title),
                          icon: const Icon(Icons.delete_forever)),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(item.title),
                      const SizedBox(
                        width: 20,
                      ),
                      //Text(item.description),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => removeAll(context, 0),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text(
            'Usun wszystko',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  }

  void removeAll(BuildContext context, value) {
    final toDoBloc = BlocProvider.of<ToDoBloc>(context);
    toDoBloc.add(const RemoveAll());
  }
}

class BuildInitail extends StatelessWidget {
  const BuildInitail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
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
            child: toDoTextInput(context),
            //dodac przycisk ze przejdz do listy tu chodzi o te 2 stany
          ),
        ]));
  }

  TextField toDoTextInput(BuildContext context) {
    return TextField(
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
    );
  }
}

void submitToDo(BuildContext context, String value) {
  final toDoBloc = BlocProvider.of<ToDoBloc>(context);
  toDoBloc.add(AddToDo(value, 'test'));
}

void changeDone(BuildContext context, value) {
  final toDoBloc = BlocProvider.of<ToDoBloc>(context);
  toDoBloc.add(DoneToDo(value));
}

void removeToDo(BuildContext context, value) {
  final toDoBloc = BlocProvider.of<ToDoBloc>(context);
  toDoBloc.add(RemoveToDo(value));
}
