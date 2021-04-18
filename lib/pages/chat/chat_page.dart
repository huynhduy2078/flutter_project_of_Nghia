import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:chat_messanger_ui/pages/chat/chat_detail_page.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/widget/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'chat_last_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _searchController = new TextEditingController();
  var provider = UserViewModel();
  double defaultSize = SizeConfig.defaultSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: ListView(
      padding: EdgeInsets.only(
          left: defaultSize * 2,
          right: defaultSize * 2,
          top: defaultSize * 1.5),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: defaultSize * 4,
              height: defaultSize * 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // image: DecorationImage(
                //     image: NetworkImage("https://..."),
                //     fit: BoxFit.cover)
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/pic.jpg"),
                ),
              ),
            ),
            Text(
              "Chats",
              style: TextStyle(
                  fontSize: defaultSize * 2.2, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.edit)
          ],
        ),
        const YMargin(10),
        Container(
          width: double.infinity,
          height: defaultSize * 4.0,
          decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(defaultSize * 1.5)),
          child: TextField(
            cursorColor: black,
            controller: _searchController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.search,
                  color: black.withOpacity(0.5),
                ),
                hintText: "Search",
                border: InputBorder.none),
          ),
        ),
        const YMargin(30),
        Column(
          children: List.generate(provider.userMessages.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatDetailPage(
                            info: provider.userMessages[index])));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: defaultSize * 7.5,
                      height: defaultSize * 7.5,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: defaultSize * 7.0,
                            height: defaultSize * 7.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(provider
                                        .userMessages[index].profilePicUrl),
                                    fit: BoxFit.cover)),
                          ),
                          provider.userMessages[index].isOnline
                              ? Positioned(
                                  top: defaultSize * 4.8,
                                  left: defaultSize * 5.2,
                                  child: Container(
                                    width: defaultSize * 2.0,
                                    height: defaultSize * 2.0,
                                    decoration: BoxDecoration(
                                        color: online,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: white, width: 3)),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    const YMargin(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          provider.userMessages[index].name,
                          style: TextStyle(
                              fontSize: defaultSize * 1.7,
                              fontWeight: FontWeight.w500),
                        ),
                        const YMargin(5),
                        LastMessage(
                            username: provider.userMessages[index].email),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        )
      ],
    ));
  }
}
