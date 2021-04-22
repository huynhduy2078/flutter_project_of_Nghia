import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/history_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat_messanger_ui/widget/divider.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function press;
  final valueNullReplace = "đang cập nhật...";

  const OrderCard({Key key, this.order, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var provider = OrderViewModel();
    UserViewModel providerUser = context.watch<UserViewModel>();
    HistoryViewModel providerHistory = context.watch<HistoryViewModel>();
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(
            defaultSize * 0.5,
          ), //18
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 1.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Mã đơn hàng: ${order.id}",
                      style: TextStyle(
                          color: black,
                          fontSize: defaultSize * 1.3,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    YMargin(defaultSize * 0.7),
                    ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: defaultSize * 3,
                      ),
                      child: Text(
                        "Nội dung: ${getContent(providerHistory)}",
                        style: TextStyle(
                            fontSize: defaultSize * 1.2, color: black),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    divider(text: "Khách hàng"),
                    Text(
                      "Khách hàng: ${order.buyer != null && order.buyer.name != null ? order.buyer.name : valueNullReplace}",
                      style: TextStyle(
                        color: black,
                      ),
                      maxLines: 1,
                    ),
                    YMargin(defaultSize * 0.5),
                    Text(
                      "Địa chỉ: ${order.buyer != null && order.buyer.address != null ? order.buyer.address : valueNullReplace}",
                      style: TextStyle(
                        color: black,
                      ),
                      maxLines: 1,
                    ),
                    YMargin(defaultSize * 0.5),
                    Text(
                      "Số điện  thoại: ${order.buyer != null && order.buyer.numberPhone != null ? order.buyer.numberPhone : valueNullReplace}",
                      style: TextStyle(
                        color: black,
                      ),
                      maxLines: 1,
                    ),
                    divider(text: "Thông tin chung"),
                    Text(
                      "Người tạo: ${providerUser.getUserByUser(order.idUser).name}",
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                    YMargin(defaultSize * 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ngày tạo: ${DateFormat('kk:mm dd/MM/yyyy').format(order.dateCreate)}",
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.defaultSize * 1.5, //20
                            vertical: SizeConfig.defaultSize * 0.5, //5
                          ),
                          decoration: BoxDecoration(
                              color: provider.getStatusById(order.status).color,
                              borderRadius: BorderRadius.circular(
                                SizeConfig.defaultSize * 1.6, // 16
                              )),
                          child: Text(
                            provider.getStatusById(order.status).status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getContent(HistoryViewModel providerHistory) {
    var history = providerHistory.getHistoryLassUpdate(order.id);
    if (history != null) {
      return history.content;
    }
    return order.content;
  }
}
