import 'package:chat_messanger_ui/pages/auth/login.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/widget/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'components/info.dart';
import 'components/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: primary,
      leading: SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("Profile"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          child: Text(
            "Đăng xuất",
            style: TextStyle(
              color: white,
              fontSize: 16, //16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  double defaultSize = SizeConfig.defaultSize;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            image: "assets/images/pic.jpg",
            name: "Nguyễn Huỳnh Duy",
            email: "Huynhduy281096@gmail.com",
          ),
          YMargin(defaultSize * 2),
          ProfileMenuItem(
            iconSrc: "assets/icons/bookmark_fill.svg",
            title: "Chức năng 1",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/chef_color.svg",
            title: "Chức năng 2",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/language.svg",
            title: "Chức năng 3",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/changePass.svg",
            title: "Change Password",
            press: () {},
          ),
        ],
      ),
    );
  }
}
