import 'package:chat_messanger_ui/core/models/nav_model.dart';
import 'package:chat_messanger_ui/pages/chat/chat_page.dart';
import 'package:chat_messanger_ui/pages/home/home_screen.dart';
import 'package:chat_messanger_ui/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class NavItems extends ChangeNotifier {
  // By default first one is selected
  int selectedIndex = 0;

  void changeNavIndex(BuildContext context, int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => items[index].destination,
        ),
      );
      notifyListeners();
    }
  }

  List<NavModel> items = [
    NavModel(
      id: 1,
      icon: "assets/icons/home.svg",
      destination: HomeScreen(),
    ),
    NavModel(
      id: 2,
      icon: "assets/icons/list.svg",
      destination: ChatPage(),
    ),
    NavModel(
      id: 3,
      icon: "assets/icons/User.svg",
      destination: ProfileScreen(),
    ),
  ];
}
