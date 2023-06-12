import 'package:github_user_search_app/data/models/user_model.dart';

abstract class UserState{}


class UserLoadingState extends UserState{}

class UserLoadedState extends UserState{
    final UserModel user;
    UserLoadedState(this.user);
}

class UserErrorState extends UserState{
  final String error;
  UserErrorState(this.error);
}

