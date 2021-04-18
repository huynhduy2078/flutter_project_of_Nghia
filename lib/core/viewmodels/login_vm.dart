import 'package:chat_messanger_ui/core/models/user_model.dart';
import 'package:chat_messanger_ui/pages/home/home_screen.dart';
import 'package:chat_messanger_ui/utils/base_auth.dart';
import 'package:chat_messanger_ui/utils/navigator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();

  BaseAuth auth = Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final TextEditingController emailTEC = new TextEditingController();
  final TextEditingController passwordTEC = new TextEditingController();

  login(BuildContext context) async {
    try {
      if (emailTEC == null || passwordTEC == null) {
        return;
      }
      _isLoading = true;
      notifyListeners();
      var user = await auth.signIn(emailTEC.text, passwordTEC.text);
      UserModel userModel = await auth.getUserProfile(user.uid);

      notifyListeners();
      print('Logged in As - ${user.name}');

      if (user != null) {
        context.navigateReplace(HomeScreen());
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
      var error = e.toString();

      if (e.toString().contains('ERROR_WRONG_PASSWORD')) {
        return showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Invalid Password"),
                  content: new Text(
                      "The password is invalid or the user does not have a password."),
                ));
      }
      if (e.toString().contains('ERROR_TOO_MANY_REQUESTS')) {
        return showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text(
                      "Too many unsuccessful login attempts. Try again later"),
                ));
      }
      if (e.toString().contains('ERROR_USER_NOT_FOUND')) {
        return showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text("This User does not exist."),
                ));
      }
      if (e.toString().contains('not a')) {
        return showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text(e.toString() ?? ''),
                ));
      }
      return showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Error"),
                content: new Text("An Error Occurred"),
              ));
    }
  }
}
