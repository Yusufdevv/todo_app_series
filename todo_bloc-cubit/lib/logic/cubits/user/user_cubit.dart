import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(User(id: '2', name: 'Alikjon')));

  User get currentUser{
    return state.user!;
  }
}

