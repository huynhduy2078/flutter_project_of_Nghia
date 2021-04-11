import 'dart:async';

import 'package:chat_messanger_ui/core/provider_registry.dart';
import 'package:chat_messanger_ui/core/viewmodels/chat_vm.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlatTextField extends HookWidget {
  const FlatTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = ChatViewModel();
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: CommonColors.grey.withOpacity(0.2)),
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
                  Container(
                    width: (MediaQuery.of(context).size.width - 140),
                    height: 40,
                    decoration: BoxDecoration(
                        color: CommonColors.border,
                        borderRadius: BorderRadius.circular(20)),
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
                        cursorColor: CommonColors.black,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (m) => provider.sendMessage(),
                        controller: provider.txt,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
