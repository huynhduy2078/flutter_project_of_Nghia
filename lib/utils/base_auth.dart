import 'dart:async';
import 'package:chat_messanger_ui/core/models/user_model.dart';
import 'package:chat_messanger_ui/core/network_layer/helper/api_helper.dart';
import 'package:flutter/material.dart';

abstract class BaseAuth {
  signIn(String email, String password);
  signUp(String email, String password);
  getCurrentUser();
  Future<void> signOut(BuildContext context);
  Future<void> resetPassword(String email, BuildContext context);
  Future<UserModel> getUserProfile(String userID);
  createUserProfile(UserModel userModel);
  updateUserProfile(UserModel userModel);
}

class Auth implements BaseAuth {
  final apiHelper = ApiHelper();
  var fakeUser = {
    "userId": "1",
    "name": "Nguyễn Huỳnh Duy",
    "phone": "0976981420",
    "isOnline": true,
    "isAdmin": true,
    "email": "Huynhduy281096@gmail.com",
    "profilePicUrl":
        "https://scontent.fdad3-3.fna.fbcdn.net/v/t1.6435-1/p200x200/147667367_2221894577947263_4563611527763467797_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=7206a8&_nc_ohc=ovQKebiHgIEAX9G9ivj&_nc_ht=scontent.fdad3-3.fna&tp=6&oh=888ac08e2e982611bce0cdf8f7e24981&oe=609E12C2"
  };

  signIn(String email, String password) async {
    try {
      // final response = await apiHelper.get(
      //   url: '',
      // );

      // print(response);
      // if (response != null)
      //   return UserModel.fromJson(response);
      // else {}
      //
      if (email == 'admin@gmail.com' && password == 'admin') {
        return UserModel.fromJson(fakeUser);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  signUp(String email, String password) async {}

  deleteAccount() async {}

  getCurrentUser() {
    return UserModel.fromJson(fakeUser);
  }

  Future<void> signOut(context) async {}

  Future<void> resetPassword(email, context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));
  }

  Future<UserModel> getUserProfile(userID) async {}

  createUserProfile(UserModel userModel) async {
    //save
  }

  updateUserProfile(UserModel userModel) async {
    //update
  }

  void updatePhoto({
    bool isCustomer = false,
    bool isAdmin = false,
    @required String photo,
  }) async {}
}
