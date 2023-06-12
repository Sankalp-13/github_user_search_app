import 'package:dio/dio.dart';
import 'package:github_user_search_app/data/models/user_search_model.dart';

import 'api/api.dart';

class UserSearchRepository{
  API api = API();

  Future<UserSearchModel> searchUser(String search) async{
    try{
      Response response =await api.sendRequest.get("/search/users?q=$search");
      UserSearchModel userModel = UserSearchModel.fromJson(response.data);
      return userModel;
    }catch(ex){
      rethrow;
    }
  }
}