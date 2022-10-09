import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial(User(id: '2', name: 'Alikjon'))) {
    on<UserEvent>((event, emit) {});
  }
  User get currentUser {
    return state.user!;
  }
}
