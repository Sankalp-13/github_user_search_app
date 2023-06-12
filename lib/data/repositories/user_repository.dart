import 'package:dio/dio.dart';
import 'package:github_user_search_app/data/models/user_model.dart';

import 'api/api.dart';

class UserRepository{
  API api = API();

  Future<UserModel> fetchPosts(username) async{
    try{
      Response response =await api.sendRequest.get("/users/$username");
      // UserModel.fromJson(response.data);
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    }catch(ex){
      rethrow;
    }
  }
}