import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';
import '../../data/models/todo.dart';

// ignore: must_be_immutable
class ManageTodo extends StatelessWidget {
  final Todo? todo;
  ManageTodo({
    this.todo,
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String _title = '';

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if (todo == null) {
      // context.read<TodoCubit>().addTodo(_title);
      context.read<TodoBloc>().add(AddNewTodoEvent(_title));
    } else {
      // context.read<TodoCubit>().editTodo(todo!.id, _title);
      context.read<TodoBloc>().add(EditTodoEvent(_title, todo!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoAdded || state is TodoEdited) {
          Navigator.of(context).pop();
        } else if (state is TodoError) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(content: Text(state.message)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: todo == null ? '' : todo!.title,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCEL'),
                    ),
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      child: Text(todo == null ? 'ADD' : 'EDIT'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
