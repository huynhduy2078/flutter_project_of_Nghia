import 'dart:js';

import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/product_vm.dart';
import 'package:provider/provider.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Order order;
  ProductItem({Key key, this.order}) : super(key: key);
  double defaultSize = SizeConfig.defaultSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getheightProduct(order.product.length),
        width: SizeConfig.screenWidth,
        color: white,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Thông tin kiện hàng",
                  style: TextStyle(
                      color: black, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                YMargin(defaultSize),
                order.product.length > 0
                    ? Expanded(
                        child: SizedBox(
                            child: new ListView.builder(
                                itemCount: order.product.length,
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ProductItemDetal(
                                            context, order.product[index]))),
                      )
                    : Text(
                        "Đang cập nhật...",
                        style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
              ],
            ),
          ),
        ));
  }

  Widget ProductItemDetal(BuildContext context, productBuyed) {
    ProductViewModel provider = context.watch<ProductViewModel>();

    Product product = provider.getProductById(productBuyed.keys.toList()[0]);

    return Column(
      children: [
        YMargin(defaultSize * 0.5),
        Container(
            decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(defaultSize * 0.8)),
            child: Row(children: [
              Container(
                width: defaultSize * 6,
                child: Padding(
                  padding: EdgeInsets.all(defaultSize * 1.5),
                  child: Container(
                    width: defaultSize * 4,
                    height: defaultSize * 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(product.profilePicUrl),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth - defaultSize * 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: black,
                        fontSize: 13,
                      ),
                    ),
                    YMargin(defaultSize * 0.5),
                    Text(
                      "${product.price} x ${productBuyed.values.toList()[0]}",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    YMargin(defaultSize * 0.5),
                  ],
                ),
              )
            ])),
      ],
    );
  }

  getheightProduct(length) {
    if (length >= 3) {
      return defaultSize * 30;
    }
    if (length < 3 && length > 0) {
      return defaultSize * 10 * length;
    }
    return defaultSize * 8;
  }
}
