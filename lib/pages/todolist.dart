import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/data/model/todo.dart';
import 'package:to_do_app/pages/widgets/elevated_Button.dart';
import 'package:to_do_app/pages/widgets/text.dart';
import 'package:to_do_app/pages/widgets/text_Field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});
  //flutter clean - do problemow z cocoaPods
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.toDoApp,
          style: const TextStyle(
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
          builder: (context, state) {
            if (state is ToDoInitial) {
              return const StartScreen();
            } else if (state is ToDoListView) {
              return ListScreen(items: state.items);
            }
            return Text(AppLocalizations.of(context)!.problem);
          },
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: MyText(
                mytext: AppLocalizations.of(context)!.startNewOrOld,
                size: 30,
              ),
            ),
            const SizedBox(height: 30),
            MyElevatedButton(
              myText: AppLocalizations.of(context)!.startNew,
              myColor: Colors.lightBlueAccent,
              onPressed: () => removeAll(context, 0),
            ),
            const SizedBox(height: 20),
            MyElevatedButton(
              myText: AppLocalizations.of(context)!.continueOld,
              myColor: Colors.lightBlueAccent,
              onPressed: () => continueOldOne(context, 0),
            ),
          ],
        ));
  }

  void removeAll(BuildContext context, value) {
    final toDoBloc = BlocProvider.of<ToDoBloc>(context);
    toDoBloc.add(const RemoveAll());
  }

  void continueOldOne(BuildContext context, value) {
    final toDoBloc = BlocProvider.of<ToDoBloc>(context);
    toDoBloc.add(const ContinueOldOne());
  }
}

class ListScreen extends StatelessWidget {
  final List<ToDoModel> items;

  const ListScreen({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                child: MyTextField(
                  myHintText: AppLocalizations.of(context)!.cleanRoom,
                  suffixIcon: const Icon(Icons.add),
                  onSubmitted: (value) => submitToDo(context, value),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
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
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => changeDone(context, item.title),
                        icon: item.isDone
                            ? const Icon(Icons.check_box)
                            : const Icon(Icons.check_box_outline_blank),
                      ),
                      IconButton(
                        onPressed: () => removeToDo(context, item.title),
                        icon: const Icon(Icons.delete_forever),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(item.title),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        MyElevatedButton(
          myText: AppLocalizations.of(context)!.removeAll,
          myColor: Colors.red,
          onPressed: () => removeAll(context, 0),
        ),
      ],
    );
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

  void removeAll(BuildContext context, value) {
    final toDoBloc = BlocProvider.of<ToDoBloc>(context);
    toDoBloc.add(const RemoveAll());
  }
}
