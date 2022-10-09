import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubits/todo/todo_cubit.dart';
import '../screens/todo_details_screen.dart';

class SearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            query = '';
          },
          child: const Text('CLEAR')),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.read<TodoCubit>().searchTodos(query);

    return todos.isEmpty
        ? const Center(
            child: Text('Can\'t find todos.'),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (ctx, i) => ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(TodoDetailsScreen.routeName, arguments: todos[i]),
              title: Text(todos[i].title),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final todos = context.read<TodoCubit>().searchTodos(query);

      return todos.isEmpty
          ? const Center(
              child: Text('Can\'t find todos.'),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, i) => ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                    TodoDetailsScreen.routeName,
                    arguments: todos[i]),
                title: Text(todos[i].title),
              ),
            );
    }
    return const SizedBox();
  }
}
