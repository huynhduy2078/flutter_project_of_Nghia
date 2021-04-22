import 'dart:async';

import 'package:chat_messanger_ui/core/viewmodels/chat_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FlatTextField extends HookWidget {
  const FlatTextField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var provider = ChatViewModel();
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: grey.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              // width: (MediaQuery.of(context).size.width),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: primary,
                  ),
                  XMargin(defaultSize * 1.5),
                  Icon(
                    Icons.photo,
                    size: 35,
                    color: primary,
                  ),
                  XMargin(defaultSize * 1.5),
                  Container(
                    width: (MediaQuery.of(context).size.width - 140),
                    height: 40,
                    decoration: BoxDecoration(
                        color: border, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        onChanged: (String text) {
                          provider.sendTyping(true);
                          if (provider.debounce.isActive)
                            provider.debounce.cancel();
                          provider.debounce =
                              Timer(const Duration(milliseconds: 2000), () {
                            provider.sendTyping(false);
                          });
                        },
                        cursorColor: black,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (m) => provider.sendMessage(),
                        controller: provider.txt,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Aa",
                            suffixIcon: Icon(
                              Icons.face,
                              color: primary,
                              size: 35,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
