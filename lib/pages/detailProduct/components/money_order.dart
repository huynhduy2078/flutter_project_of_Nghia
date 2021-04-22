import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class MoneyOrder extends StatelessWidget {
  final Order order;
  MoneyOrder({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    var provider = OrderViewModel();
    double transportFee = provider.getMoneyBill(order.id) > 0 ? 30000 : 0;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tạm tính",
                      style: TextStyle(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "${provider.getMoneyBill(order.id)} đ",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                new Divider(
                  color: bg,
                ),
                YMargin(defaultSize * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phí vận chuyển",
                      style: TextStyle(
                        color: black,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "+$transportFee đ",
                      style: TextStyle(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                new Divider(
                  color: bg,
                ),
                YMargin(defaultSize * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thành tiền",
                      style: TextStyle(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${provider.getMoneyBill(order.id) + transportFee} đ",
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
