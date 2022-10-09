import 'package:flutter/material.dart';
import '../../data/models/todo.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/todo-details';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments  as Todo;
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(todo.title),),
    );
  }
}