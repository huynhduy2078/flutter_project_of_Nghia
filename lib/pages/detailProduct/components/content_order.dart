import 'package:chat_messanger_ui/core/models/history_model.dart';
import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/history_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:chat_messanger_ui/widget/divider.dart';
import 'package:chat_messanger_ui/widget/loader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class ContentOrder extends StatefulWidget {
  final Order order;
  ContentOrder({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;

  @override
  _ContentOrder createState() => _ContentOrder();
}

class _ContentOrder extends State<ContentOrder> {
  @override
  Widget build(BuildContext context) {
    HistoryViewModel provider = context.watch<HistoryViewModel>();
    OrderViewModel providerOrder = context.watch<OrderViewModel>();
    var data = providerOrder.getContentHistory(widget.order.id);

    double defaultSize = SizeConfig.defaultSize;
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
                      "Người tạo: ${data['name']}",
                      style: TextStyle(color: black, fontSize: 13),
                    ),
                    Text(
                      DateFormat('kk:mm dd/MM/yyyy').format(data['dateUpdate']),
                      style: TextStyle(color: black, fontSize: 13),
                    ),
                  ],
                ),
                divider(text: "Nội dung:"),
                Text(
                  data['content'],
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
                        onPressed: () =>
                            openAlertBox(context, data, widget.order))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

openAlertBox(context, data, order) {
  double defaultSize = SizeConfig.defaultSize;
  final controller = TextEditingController(text: data['content']);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Container(
            width: SizeConfig.screenWidth * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Update order:",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
                YMargin(defaultSize * 2),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field can't be left empty";
                      }
                      return null;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Update nội dung",
                      border: InputBorder.none,
                    ),
                    maxLines: 10,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<HistoryViewModel>().addHistorynewOrder(
                        order.id, data['idUser'], controller.text);
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    children: [
                      YMargin(defaultSize),
                      context.read<OrderViewModel>().isLoading
                          ? Loader()
                          : Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: primary.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Update thông tin",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
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
      });
}
