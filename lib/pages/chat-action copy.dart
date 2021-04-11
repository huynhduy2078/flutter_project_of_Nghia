import 'dart:async';

import 'package:chat_messanger_ui/core/provider_registry.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlatTextField extends HookWidget {
  const FlatTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(chatVM);
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.altColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Container(
        width: (MediaQuery.of(context).size.width - 140) / 2,
        height: 40,
        decoration: BoxDecoration(
            color: CommonColors.grey, borderRadius: BorderRadius.circular(20)),
        //padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //prefix ?? SizedBox(width: 0, height: 0,),
            Expanded(
              child: TextField(
                  cursorColor: CommonColors.black,
                  onChanged: (String text) {
                    // provider.sendTyping(true);
                    // if (provider.debounce.isActive) provider.debounce.cancel();
                    // provider.debounce =
                    //     Timer(const Duration(milliseconds: 2000), () {
                    //   provider.sendTyping(false);
                    // });
                  },
                  textInputAction: TextInputAction.send,
                  // onSubmitted: (m) => provider.sendMessage(),
                  // controller: provider.txt,
                  decoration: InputDecoration(
                    hintText: "Enter Message...",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(
                      16.0,
                    ),
                  ),
                  style: TextStyle(color: Colors.white)),
            ),

            IconButton(
              icon: Icon(
                FluentIcons.send_28_filled,
                size: 24.0,
                color: Colors.green,
              ),
              onPressed: () => {},
              // onPressed: provider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
