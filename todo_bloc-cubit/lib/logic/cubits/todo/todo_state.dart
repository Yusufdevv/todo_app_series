// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_cubit.dart';

@immutable
 class TodoState {
  final List<Todo>? todos;

  const TodoState({this.todos});
}

class TodoInitial extends TodoState {
  final List<Todo> todos;
  
  const TodoInitial(this.todos);
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  
  const TodoLoaded(this.todos) : super(todos: todos);
}

class TodoAdded extends TodoState{
}

class TodoEdited extends TodoState{
}
class TodoToggled extends TodoState{
}
class TodoDeleted extends TodoState{
}


class TodoError extends TodoState{
  final String message;
  const TodoError(this.message);
}