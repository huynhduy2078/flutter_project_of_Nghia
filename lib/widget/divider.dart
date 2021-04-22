import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class divider extends StatelessWidget {
  const divider({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(right: defaultSize),
            child: Divider(
              color: black,
              height: defaultSize * 2.2,
            )),
      ),
      Text(
        text,
        style: TextStyle(
          color: black,
          fontSize: defaultSize * 0.8,
        ),
      ),
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(left: defaultSize),
            child: Divider(
              color: black,
              height: defaultSize * 2.2,
            )),
      ),
    ]);
  }
}
