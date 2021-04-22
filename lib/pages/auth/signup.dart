import 'package:chat_messanger_ui/core/viewmodels/signup_vm.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/utils/validator.dart';
import 'package:chat_messanger_ui/widget/default_button.dart';
import 'package:chat_messanger_ui/widget/loader.dart';
import 'package:chat_messanger_ui/widget/text_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<SignupViewModel>();
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: altBg,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: Form(
        key: provider.formKey,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              YMargin(defaultSize * 2),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Signup',
                      style: TextStyle(
                          fontSize: defaultSize * 2.5,
                          color: blue,
                          fontWeight: FontWeight.w900),
                    ),
                    YMargin(defaultSize),
                    Text(
                      'Hello there!',
                      style:
                          TextStyle(fontSize: defaultSize * 2.5, color: black),
                    ),
                    Text(
                      'welcome to you',
                      style:
                          TextStyle(fontSize: defaultSize * 2.5, color: black),
                    ),
                  ],
                ),
              ),
              YMargin(defaultSize * 3),
              TextFieldCommon(
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Please enter a valid Name";
                  }
                },
                controller: provider?.nameTEC,
                hintText: 'Full Name',
              ),
              YMargin(defaultSize * 2),
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
                  if (value.length >= 10) {
                    provider.phone = value;
                    return null;
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Invalid phone number";
                  }
                },
                isPhone: true,
                hintText: 'Phone Number',
                controller: provider?.phoneTEC,
              ),
              YMargin(context.screenHeight(percent: 0.08)),
              provider.isLoading
                  ? Loader()
                  : Container(
                      width: context.screenWidth(),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 55,
                      child: DefaultButton(
                        text: "Signup",
                        press: () {
                          if (provider.formKey.currentState.validate())
                            provider.signup(context);
                        },
                      ),
                    ),
              YMargin(defaultSize * 3),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?  ',
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 14,
                          color: blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              YMargin(defaultSize * 9),
            ],
          ),
        ),
      ),
    );
  }
}
