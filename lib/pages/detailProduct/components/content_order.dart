import 'package:chat_messanger_ui/core/models/history_model.dart';
import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/history_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:chat_messanger_ui/widget/divider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class ContentOrder extends StatelessWidget {
  final Order order;
  ContentOrder({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    HistoryViewModel provider = context.watch<HistoryViewModel>();
    UserViewModel providerUser = context.watch<UserViewModel>();
    HistoryModel history = provider.getHistoryLassUpdate(order.id);
    return Container(
        width: SizeConfig.screenWidth,
        color: white,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(defaultSize * 0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nội dung đơn hàng",
                  style: TextStyle(
                      color: black, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                YMargin(defaultSize * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Người tạo: ${providerUser.getUserByUser(history.idUserCreate).name}",
                      style: TextStyle(color: black, fontSize: 13),
                    ),
                    Text(
                      DateFormat('kk:mm dd/MM/yyyy').format(history.dateUpdate),
                      style: TextStyle(color: black, fontSize: 13),
                    ),
                  ],
                ),
                divider(text: "Nội dung:"),
                Text(
                  history.content,
                  style: TextStyle(
                    color: black,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.justify,
                ),
                YMargin(defaultSize * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        child: Text(
                          "Xem lịch sử chỉnh sửa",
                          style: TextStyle(
                            color: blue,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () => {provider.showHistory = true}),
                    TextButton(
                        child: Text(
                          "Chỉnh sửa",
                          style: TextStyle(
                            color: blue,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () => {})
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
