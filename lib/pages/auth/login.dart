import 'dart:async';

import 'package:chat_messanger_ui/core/viewmodels/login_vm.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/utils/validator.dart';
import 'package:chat_messanger_ui/widget/default_button.dart';
import 'package:chat_messanger_ui/widget/loader.dart';
import 'package:chat_messanger_ui/widget/text_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_messanger_ui/utils/navigator.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoginViewModel provider = context.watch<LoginViewModel>();
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Material(
      child: Container(
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              color: white,
            ),
            ListView(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(defaultSize * 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: defaultSize * 2.5,
                                  color: blue,
                                  fontWeight: FontWeight.w900),
                            ),
                            YMargin(defaultSize),
                            Text(
                              'Hello there!',
                              style: TextStyle(
                                  fontSize: defaultSize * 2.5, color: black),
                            ),
                            Text(
                              'welcome back',
                              style: TextStyle(
                                  fontSize: defaultSize * 2.5, color: black),
                            ),
                          ],
                        ),
                      ),
                      YMargin(defaultSize * 3),
                      Form(
                        key: formKey,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              YMargin(defaultSize * 4),
                              TextFieldCommon(
                                validator: (value) {
                                  if (Validator.isEmail(value)) {
                                    return null;
                                  } else if (value.isEmpty) {
                                    return "This field can't be left empty";
                                  } else {
                                    return "Please enter a valid Email";
                                  }
                                },
                                controller: provider?.emailTEC,
                                hintText: 'Email',
                              ),
                              YMargin(defaultSize * 2),
                              TextFieldCommon(
                                validator: (value) {
                                  if (Validator.isPassword(value)) {
                                    return null;
                                  } else if (value.isEmpty) {
                                    return "This field can't be left empty";
                                  } else {
                                    return "Please enter a valid Password";
                                  }
                                },
                                hintText: 'Password',
                                controller: provider?.passwordTEC,
                                isPassword: true,
                              ),
                              YMargin(context.screenHeight(percent: 0.1)),
                              provider.isLoading
                                  ? Loader()
                                  : Container(
                                      width: context.screenWidth(),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      height: 60,
                                      child: DefaultButton(
                                        text: "Login",
                                        press: () {
                                          if (formKey.currentState.validate())
                                            provider.login(context);
                                        },
                                      ),
                                    ),
                              YMargin(defaultSize * 3),
                              InkResponse(
                                onTap: () => context.navigate(Signup()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Don’t have an account?  ',
                                      style: TextStyle(
                                          fontSize: 14, color: textColor),
                                    ),
                                    Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontSize: defaultSize * 1.4,
                                          color: blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              YMargin(defaultSize * 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
