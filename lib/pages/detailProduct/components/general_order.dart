import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:intl/intl.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GeneralOrder extends StatelessWidget {
  final Order order;
  GeneralOrder({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    var provider = OrderViewModel();
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
                  "Mã đơn hàng: ${order.id}",
                  style: TextStyle(
                      color: black, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                YMargin(defaultSize * 0.5),
                Text(
                  "Ngày tạo đơn: ${DateFormat('kk:mm dd/MM/yyyy').format(order.dateCreate)}",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                  ),
                ),
                YMargin(defaultSize * 0.5),
                Row(
                  children: [
                    Text(
                      "Trạng thái: ${provider.getStatusById(order.status).status}",
                      style: TextStyle(
                          color: black,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600),
                    ),
                    XMargin(defaultSize),
                    TextButton(
                        child: Text(
                          "Thay đổi",
                          style: TextStyle(
                            color: blue,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () => {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                  actions: provider
                                      .getStatusByUpdate(order.status)
                                      .map((item) => CupertinoActionSheetAction(
                                            child: Text(
                                              item.status,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: black, fontSize: 15),
                                            ),
                                            onPressed: () {},
                                          ))
                                      .toList(),
                                  cancelButton: CupertinoActionSheetAction(
                                    child: Text(
                                      "Hủy",
                                      textAlign: TextAlign.justify,
                                      style:
                                          TextStyle(color: black, fontSize: 15),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              )
                            })
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
