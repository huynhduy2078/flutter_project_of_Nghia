import 'package:chat_messanger_ui/core/models/history_model.dart';
import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/history_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:intl/intl.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryEdit extends StatelessWidget {
  final Order order;
  HistoryEdit({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    HistoryViewModel provider = context.watch<HistoryViewModel>();
    List<HistoryModel> history = provider.getHistoryById(order.id);
    return provider.showHistory
        ? Container(
            width: SizeConfig.screenWidth,
            height: getheightHistory(history.length),
            color: white,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(defaultSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lịch sử chỉnh sửa",
                          style: TextStyle(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            child: Text(
                              "Ẩn",
                              style: TextStyle(
                                color: blue,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () => {provider.showHistory = false})
                      ],
                    ),
                    YMargin(defaultSize * 0.5),
                    history.length > 0
                        ? Expanded(
                            child: SizedBox(
                                child: new ListView.builder(
                                    itemCount: history.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        histotyEdit(context, history[index]))),
                          )
                        : Text(
                            "Không có lịch sử chỉnh sửa",
                            style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.w200),
                          )
                  ],
                ),
              ),
            ))
        : Container();
  }

  Widget histotyEdit(BuildContext context, HistoryModel history) {
    UserViewModel providerUser = context.watch<UserViewModel>();
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(defaultSize * 0.8)),
            alignment: Alignment.center,
            child: Row(children: [
              Container(
                width: defaultSize * 12,
                child: Padding(
                  padding: EdgeInsets.all(defaultSize * 1.5),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        providerUser.getUserByUser(history.idUserCreate).name,
                        style: TextStyle(
                          color: black,
                          fontSize: 13,
                        ),
                      ),
                      YMargin(defaultSize * 0.5),
                      Text(
                        "${DateFormat('kk:mm dd/MM/yyyy').format(history.dateUpdate)}",
                        style: TextStyle(
                          color: black,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Container(
                  height: defaultSize * 4,
                  child: VerticalDivider(color: black)),
              Container(
                width: SizeConfig.screenWidth - defaultSize * 17,
                child: Text(
                  history.content,
                  style: TextStyle(
                    color: black,
                    fontSize: 13,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ])),
        YMargin(defaultSize * 0.5),
      ],
    );
  }

  getheightHistory(length) {
    if (length >= 4) {
      return defaultSize * 31;
    }
    if (length == 3) {
      return defaultSize * 25;
    }
    if (length == 2) {
      return defaultSize * 18;
    }

    if (length == 1) {
      return defaultSize * 11;
    }
    return defaultSize * 7;
  }
}
