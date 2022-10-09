part of 'completed_todos_bloc.dart';

@immutable
abstract class CompletedTodosState {}

class CompletedTodosInitial extends CompletedTodosState {}

class CompletedTodosLoaded extends CompletedTodosState {
  final List<Todo> todos;

  CompletedTodosLoaded(this.todos);
}