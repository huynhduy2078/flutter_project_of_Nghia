import 'dart:math';

import 'package:chat_messanger_ui/constant/eventIcon.dart';
import 'package:chat_messanger_ui/constant/eventMessage.dart';
import 'package:chat_messanger_ui/constant/data.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:chat_messanger_ui/widget/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _sendMessageController = new TextEditingController();

  get id => null;

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
          // Icon(
          //   LineIcons.video_camera,
          //   color: primary,
          //   size: 35,
          // ),
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
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: CommonColors.grey.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add_circle,
                    size: 35,
                    color: CommonColors.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: CommonColors.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.photo,
                    size: 35,
                    color: CommonColors.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.keyboard_voice,
                    size: 35,
                    color: CommonColors.primary,
                  ),
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Row(
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width - 140) / 2,
                    height: 40,
                    decoration: BoxDecoration(
                        color: CommonColors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        cursorColor: CommonColors.black,
                        controller: _sendMessageController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Aa",
                            suffixIcon: Icon(
                              Icons.face,
                              color: CommonColors.primary,
                              size: 35,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.thumb_up,
                    size: 35,
                    color: CommonColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return Container(
      color: CommonColors.bg_room,
      child: ListView(
        padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 80),
        children: List.generate(messages.length, (index) {
          return ChatBubble(
            id: messages[index]['idMessage'],
            isMe: messages[index]['isMe'],
            messageType: messages[index]['messageType'],
            message: messages[index]['message'],
            icon: messages[index]['icon'],
            profileImg: messages[index]['profileImg'],
          );
        }),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String id;
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  final bool icon;

  const ChatBubble(
      {Key key,
      this.id,
      this.isMe,
      this.profileImg,
      this.message,
      this.messageType,
      this.icon})
      : super(key: key);

  Widget build(BuildContext context) {
    if (isMe) {
      return Container(
        width: (MediaQuery.of(context).size.width - 40),
        child: Padding(
          padding: EdgeInsets.fromLTRB(1, 1, 1, (icon == true ? 10.0 : 1.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: [
                        CustomPopupMenu(
                          barrierColor: CommonColors.transparent,
                          pressType: PressType.longPress,
                          showArrow: false,
                          listEventIcon: listEventIcon,
                          onChangeIcon: (int value) {
                            print(value);
                          },
                          onShowIcon: (bool value) {
                            //isShowIcon = true;
                          },
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: 50,
                                maxWidth:
                                    (MediaQuery.of(context).size.width * 0.7)),
                            decoration: BoxDecoration(
                                color: CommonColors.bg_ms_me,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                message,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: CommonColors.black, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  icon == true
                      ? Positioned.fill(
                          child: Align(
                          alignment: Alignment.bottomRight,
                          child: FractionalTranslation(
                            translation: Offset(-0.1, 0.4),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CommonColors.white,
                                  border: Border.all(
                                      color: CommonColors.black, width: 0.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(profileImg),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          ),
                        ))
                      : Container()
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, (icon == true ? 10.0 : 1.0)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(profileImg),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                child: Flexible(
                  child: Stack(
                    children: <Widget>[
                      // CustomPopupMenu(
                      //   verticalMargin: -5.0,
                      //   barrierColor: CommonColors.transparent,
                      //   pressType: PressType.longPress,
                      //   child: Container(
                      //     constraints: BoxConstraints(
                      //         minWidth: 50,
                      //         maxWidth:
                      //             (MediaQuery.of(context).size.width * 0.7)),
                      //     decoration: BoxDecoration(
                      //         color: CommonColors.white,
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(15))),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(13.0),
                      //       child: Text(
                      //         message,
                      //         textAlign: TextAlign.justify,
                      //         style: TextStyle(
                      //             color: CommonColors.black, fontSize: 16),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      icon == true
                          ? Positioned.fill(
                              child: Align(
                              alignment: Alignment.bottomRight,
                              child: FractionalTranslation(
                                translation: Offset(-0.1, 0.4),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CommonColors.white,
                                      border: Border.all(
                                          color: CommonColors.black,
                                          width: 0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(profileImg),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

// class CustomPopupMenuController extends ChangeNotifier {
//   bool menuIsShowing = false;

//   Future<void> showMenu() async {
//    print("show");
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setBool('isShowPopUpMessage', true);
//   }

//   Future<void> hideMenu() async {
//     print("vao dÿy");
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setBool('isShowPopUpMessage', false);
//   }

//   void toggleMenu() {
//   }
// }
