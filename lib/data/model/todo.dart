import 'package:equatable/equatable.dart';

class ToDoModel extends Equatable {
  final String title;
  final String description;
  final bool isDone;

  ToDoModel({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  @override
  List<Object> get props => [
        title,
        description,
        isDone,
      ];

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "isDone": isDone,
      };
}