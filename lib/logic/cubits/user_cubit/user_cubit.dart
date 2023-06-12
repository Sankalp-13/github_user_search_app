import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search_app/data/models/user_model.dart';
import 'package:github_user_search_app/data/repositories/user_repository.dart';
import 'package:github_user_search_app/logic/cubits/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit(String username): super(UserLoadingState()) {
    fetchPosts(username);
  }

  UserRepository userRepository = UserRepository();

  void fetchPosts(String username) async{
    try{
      UserModel user = await userRepository.fetchPosts(username);
      emit(UserLoadedState(user));
    }on DioException catch(ex){
      emit(UserErrorState(ex.toString()));
    }
  }

}