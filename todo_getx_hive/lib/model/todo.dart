import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  bool isCompleted;

  Todo({required this.title})
      : id = UniqueKey().toString(),
        isCompleted = false;
}
