import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  late final StreamSubscription todoBlocSubscription;
  final TodoBloc todoBloc;
  ActiveTodosBloc(this.todoBloc) : super(ActiveTodosInitial()) {
    todoBlocSubscription = todoBloc.stream.listen(
      (event) {
        add(LoadedActiveTodosEvent());
      }
    );
    on<LoadedActiveTodosEvent>(_getActiveTodos);
  }

  void _getActiveTodos(LoadedActiveTodosEvent event, Emitter<ActiveTodosState> emit) {
    final todos = todoBloc.state.todos!.where((todo) => !todo.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoBlocSubscription.cancel();
    return super.close();
  }
}
