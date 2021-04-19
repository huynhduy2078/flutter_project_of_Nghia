import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_messanger_ui/utils/navigator.dart';
import 'package:chat_messanger_ui/core/viewmodels/product_vm.dart';
import 'package:provider/provider.dart';

import 'find_people_create.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["NEW", "EDIT", "CONFIRMED", "CONFIRMING", "DONE", "CANCEL"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
      child: Column(
        children: [
          buildPepleCreate(),
          const YMargin(10),
          SizedBox(
            height: SizeConfig.defaultSize * 3.5, // 35
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => buildCategoriItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2, //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color:
                selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6, // 16
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? primary : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }

  Widget buildPepleCreate() {
    return GestureDetector(
      onTap: () => context.navigate(FindPeopleCreate()),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: SizeConfig.defaultSize * 2,
            right: SizeConfig.defaultSize * 2),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Người tạo đơn:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Text(
                  context.read<ProductViewModel>().getNumberPeopleCreate(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const XMargin(10),
                SvgPicture.asset("assets/icons/arrow_right.svg",
                    height: 13, width: 13),
              ],
            )
          ],
        ),
      ),
    );
  }
}
