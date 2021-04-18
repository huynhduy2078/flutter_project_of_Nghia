import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key key, this.hintText, this.onChanged}) : super(key: key);

  final String hintText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.65,
      decoration: BoxDecoration(
        color: secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hintText,
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
