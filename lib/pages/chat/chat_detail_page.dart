import 'package:chat_messanger_ui/core/models/user_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/chat_vm.dart';
import 'package:chat_messanger_ui/pages/chat/chat-action.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({
    Key key,
    this.info,
  }) : super(key: key);
  final UserModel info;

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  var provider = ChatViewModel();
  @override
  void initState() {
    super.initState();
    provider.connectToServer();
  }

  double defaultSize = SizeConfig.defaultSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg_room,
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
        title: Row(
          children: <Widget>[
            Container(
              width: defaultSize * 4.0,
              height: defaultSize * 4.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(widget.info.profilePicUrl),
                      fit: BoxFit.cover)),
            ),
            XMargin(defaultSize * 1.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.info.name,
                  style: TextStyle(
                      fontSize: defaultSize * 1.8,
                      fontWeight: FontWeight.bold,
                      color: black),
                ),
                YMargin(defaultSize * 0.3),
                Text(
                  "Active now",
                  style: TextStyle(
                      color: black.withOpacity(0.4),
                      fontSize: defaultSize * 1.4),
                )
              ],
            )
          ],
        ),
      ),
      body: getBody(),
      bottomSheet: getBottom(),
    );
  }

  Widget getBottom() {
    return FlatTextField();
  }

  Widget getBody() {
    return Container(
      color: bg_room,
      child: Column(
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.only(
                  right: defaultSize * 2.0,
                  left: defaultSize * 2.0,
                  top: defaultSize * 2.0,
                  bottom: defaultSize * 8.0),
              children: [...provider.messages],
            ),
          ),
        ],
      ),
    );
  }
}
