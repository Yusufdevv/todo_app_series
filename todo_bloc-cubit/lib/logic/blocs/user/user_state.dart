part of 'user_bloc.dart';

@immutable

abstract class UserState {
  final User? user;
 const UserState({ this.user});
}

class UserInitial extends UserState {
  const UserInitial(User user) : super(user: user);
}