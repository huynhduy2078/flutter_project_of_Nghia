import 'package:chat_messanger_ui/core/viewmodels/nav_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Consumer<NavItems>(
      builder: (context, navItems, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 3), //30
        // just for demo
        // height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -7),
              blurRadius: 30,
              color: Color(0xFF4B1A39).withOpacity(0.2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              navItems.items.length,
              (index) => buildIconNavBarItem(
                isActive: navItems.selectedIndex == index ? true : false,
                icon: navItems.items[index].icon,
                press: () {
                  navItems.changeNavIndex(context, index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildIconNavBarItem(
      {String icon, Function press, bool isActive = false}) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        color: isActive ? primary : Color(0xFFD1D4D4),
        height: 22,
      ),
      onPressed: press,
    );
  }
}
