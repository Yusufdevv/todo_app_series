import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/blocs/active_todos/active_todos_bloc.dart';
import 'package:todo_cubit/logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';
import '../../data/constants/tab_title_constants.dart';
import '../widgets/search_bar.dart';
import '../widgets/manage_todo.dart';

import '../widgets/todo_list_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool _init = false;

  @override
  void didChangeDependencies() {
    if (!_init) {
      // context.read<TodoCubit>().getTodos();
      context.read<TodoBloc>().add(LoadTodosEvent());
      
      // context.read<ActiveTodosCubit>().getActiveTodos();
      context.read<ActiveTodosBloc>().add(LoadedActiveTodosEvent());

      // context.read<CompletedTodosCubit>().getCompletedTodos();
      context.read<CompletedTodosBloc>().add(LoadCompletedTodosEvent());
    }
    _init = true;
    super.didChangeDependencies();
  }

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (ctx) => ManageTodo(),
    );
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBar());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitleSContants.tabs.length,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('TODO CUBIT'),
            actions: [
              IconButton(
                  onPressed: () => openSearchBar(context),
                  icon: const Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  openManageTodo(context);
                },
                icon: const Icon(Icons.add),
              )
            ],
            bottom: TabBar(
                tabs: TabTitleSContants.tabs
                    .map((tab) => Tab(
                          text: tab,
                        ))
                    .toList()),
          ),
          body: TabBarView(children: [
            BlocBuilder<TodoBloc, TodoState>(
              // todo: listener => o'rniga StreamSubscriotion iwlatsa ham bo'ladi
              // listener: (context, state) {
              //   context.read<ActiveTodosCubit>().getActiveTodos();
              // },
              builder: (context, state) {
                if (state is TodoLoaded) {
                  return state.todos.isEmpty ? const Center(
                  child: Text('No todos'),
                ) : ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (ctx, i) => TodoListItem(todo: state.todos[i]),
                  );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
            BlocBuilder<ActiveTodosBloc, ActiveTodosState>(
              builder: (context, state) {
                if (state is ActiveTodosLoaded) {
                  return state.todos.isEmpty ? const Center(
                  child: Text('No active todos'),
                ) : ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (ctx, i) => TodoListItem(todo: state.todos[i]),
                  );
                }
                return const Center(
                  child: Text('No active todos'),
                );
              },
            ),
            BlocBuilder<CompletedTodosBloc, CompletedTodosState>(
              builder: (context, state) {
                if (state is CompletedTodosLoaded) {
                  return state.todos.isEmpty ? const Center(
                  child: Text('No completed todos'),
                ) : ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (ctx, i) => TodoListItem(todo: state.todos[i]),
                  );
                }
                return const Center(
                  child: Text('No completed todos'),
                );
              },
            ),
          ])),
    );
  }
}
