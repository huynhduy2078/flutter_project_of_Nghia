import 'package:chat_messanger_ui/core/models/user_model.dart';
import 'package:chat_messanger_ui/pages/home/home_screen.dart';
import 'package:chat_messanger_ui/utils/base_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_messanger_ui/utils/navigator.dart';

class SignupViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  BaseAuth auth = Auth();

  final TextEditingController emailTEC = new TextEditingController();
  final TextEditingController nameTEC = new TextEditingController();
  final TextEditingController phoneTEC = new TextEditingController();
  final TextEditingController passwordTEC = new TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _phone;
  String get phone => _phone;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set phone(String val) {
    _phone = val;
    notifyListeners();
  }

  signup(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      var user = await auth.signUp(emailTEC.text, passwordTEC.text);
      if (user != null) {}
      UserModel userModel = UserModel(
          name: nameTEC.text,
          email: emailTEC.text,
          phone: _phone,
          profilePicUrl: '',
          userId: user.uid,
          isAdmin: false);

      await auth.createUserProfile(userModel);
      emailTEC.text = '';
      nameTEC.text = '';
      passwordTEC.text = '';
      notifyListeners();

      print('Signed up as - ${userModel.name}');

      // if (user != null) context.navigate(SelectPlan(userModel));
      if (user != null) context.navigateReplace(HomeScreen());
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
