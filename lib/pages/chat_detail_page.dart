import 'dart:math';

import 'package:chat_messanger_ui/constant/evenSelectMessage.dart';
import 'package:chat_messanger_ui/constant/eventMessage.dart';
import 'package:chat_messanger_ui/constant/data.dart';
import 'package:chat_messanger_ui/pages/chat-bubble_2.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:chat_messanger_ui/widget/custom_pop_up_menu.dart';
import 'package:chat_messanger_ui/pages/chat-action.dart';
import 'package:chat_messanger_ui/widget/message_item.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _sendMessageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.bg_room,
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: CommonColors.black,
            )),
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tyler Nix",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CommonColors.black),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Active now",
                  style: TextStyle(
                      color: CommonColors.black.withOpacity(0.4), fontSize: 14),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          Icon(
            LineIcons.phone,
            color: CommonColors.primary,
            size: 32,
          ),
          SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
                color: CommonColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: CommonColors.white)),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: getBody(),
      bottomSheet: getBottom(),
    );
  }

  Widget getBottom() {
    return FlatTextField();
  }

  Widget getBody() {
    return MessageItem();
  }
}
