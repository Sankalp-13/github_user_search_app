import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search_app/data/repositories/user_search_repository.dart';
import 'package:github_user_search_app/logic/cubits/user_search_cubit/user_search_state.dart';

import '../../../data/models/user_search_model.dart';

class UserSearchCubit extends Cubit<UserSearchState>{
  UserSearchCubit(): super(UserSearchInitialState());

  UserSearchRepository userRepository = UserSearchRepository();

  void searchUser(String search) async{
    try{
      emit(UserSearchLoadingState());
      UserSearchModel user = await userRepository.searchUser(search);
      emit(UserSearchLoadedState(user));
    }on DioException catch(ex){
      if(ex.type == DioExceptionType.badResponse) {
        emit(UserSearchErrorState("Invalid Search!"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(UserSearchErrorState("Can't connect to github!"));
      }else{
        emit(UserSearchErrorState(ex.type.toString()));
      }
    }
  }
}