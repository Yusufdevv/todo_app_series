import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/blocs/active_todos/active_todos_bloc.dart';
import 'package:todo_cubit/logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:todo_cubit/logic/blocs/user/user_bloc.dart';
import 'logic/cubits/active_todos/active_todos_cubit.dart';
import 'logic/cubits/completed_todos/completed_todos_cubit.dart';
import 'logic/cubits/todo/todo_cubit.dart';
import 'logic/cubits/user/user_cubit.dart';
import 'presentation/screens/todo_details_screen.dart';
import 'presentation/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => UserCubit()),
        BlocProvider(
            create: (ctx) => TodoCubit(userCubit: ctx.read<UserCubit>())),
        BlocProvider(create: (ctx) => ActiveTodosCubit(ctx.read<TodoCubit>())),
        BlocProvider(
            create: (ctx) => CompletedTodosCubit(ctx.read<TodoCubit>())),
        BlocProvider(create: (ctx) => UserBloc()),
        BlocProvider(create: (ctx) => TodoBloc(ctx.read<UserBloc>())),
        BlocProvider(create: (ctx) => ActiveTodosBloc(ctx.read<TodoBloc>())),
        BlocProvider(create: (ctx) => CompletedTodosBloc(ctx.read<TodoBloc>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: TodoScreen.routeName,
        routes: {
          TodoScreen.routeName: (context) => const TodoScreen(),
          TodoDetailsScreen.routeName: (context) => const TodoDetailsScreen()
        },
      ),
    );
  }
}
