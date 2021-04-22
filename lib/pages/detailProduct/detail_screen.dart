import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:chat_messanger_ui/widget/divider.dart';
import 'components/buyer_order.dart';
import 'components/content_order.dart';
import 'components/general_order.dart';
import 'components/history_edit.dart';
import 'components/money_order.dart';
import 'components/product_item.dart';

class DetailScreen extends StatefulWidget {
  final Order order;
  const DetailScreen({Key key, this.order}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;
  double defaultSize = SizeConfig.defaultSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(order: widget.order),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: primary,
      centerTitle: true,
      title: Text("Chi tiết đơn hàng"),
    );
  }
}

class Body extends StatelessWidget {
  double defaultSize = SizeConfig.defaultSize;
  final Order order;
  Body({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: bg,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: defaultSize * 0.4, horizontal: defaultSize * 0.8),
              child: GeneralOrder(order: order),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: defaultSize * 0.4, horizontal: defaultSize * 0.8),
              child: ContentOrder(order: order),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: defaultSize * 0.4, horizontal: defaultSize * 0.8),
              child: HistoryEdit(order: order),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: defaultSize * 0.4, horizontal: defaultSize * 0.8),
                child: BuyerOrder(order: order)),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: defaultSize * 0.4, horizontal: defaultSize * 0.8),
              child: ProductItem(order: order),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: defaultSize * 0.4, horizontal: defaultSize * 0.8),
              child: MoneyOrder(order: order),
            ),
          ],
        ),
      ),
    );
  }
}
