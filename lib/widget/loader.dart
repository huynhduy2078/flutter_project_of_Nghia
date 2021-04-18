import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 4,
            color: primary.withOpacity(0.9),
            child: LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
