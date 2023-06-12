import 'package:github_user_search_app/data/models/user_search_model.dart';

abstract class UserSearchState{}

class UserSearchInitialState extends UserSearchState{}

class UserSearchLoadingState extends UserSearchState{}

class UserSearchLoadedState extends UserSearchState{
  final UserSearchModel users;
  UserSearchLoadedState(this.users);
}

class UserSearchErrorState extends UserSearchState{
  final String error;
  UserSearchErrorState(this.error);
}

