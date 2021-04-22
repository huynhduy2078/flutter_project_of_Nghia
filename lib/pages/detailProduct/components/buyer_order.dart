import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class BuyerOrder extends StatelessWidget {
  final Order order;
  BuyerOrder({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;
  final valueNullReplace = "đang cập nhật...";

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        color: white,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Địa chỉ người nhận",
                  style: TextStyle(
                      color: black, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                YMargin(defaultSize * 0.5),
                Text(
                  "Tên khách hàng: ${order.buyer.name != null ? order.buyer.name : valueNullReplace}",
                  style: TextStyle(
                      color: black, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                YMargin(defaultSize * 0.5),
                Text(
                  "Số điện thoại: ${order.buyer.numberPhone != null ? order.buyer.numberPhone : valueNullReplace}",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12.5,
                  ),
                ),
                YMargin(defaultSize * 0.5),
                Text(
                  "Địa chỉ: ${order.buyer.address != null ? order.buyer.address : valueNullReplace}",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12.5,
                  ),
                ),
                YMargin(defaultSize * 0.5),
              ],
            ),
          ),
        ));
  }
}
