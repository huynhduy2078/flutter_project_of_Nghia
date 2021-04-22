import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/widget/loader.dart';
import 'package:chat_messanger_ui/widget/search_field.dart';
import 'package:flutter/material.dart';
import 'icon_btn_with_counter.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderViewModel provider = context.watch<OrderViewModel>();
    return Container(
      color: primary,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchField(
                hintText: "Serach Order",
                controller: provider.textSearch,
                onChanged: (e) => {
                      provider.findOrder(),
                    }),
            IconBtnWithCounter(
              svgSrc: "assets/icons/Settings.svg",
              press: () => {provider.showFind = !provider.showFind},
            ),
            IconBtnWithCounter(
              svgSrc: "assets/icons/Plus Icon.svg",
              press: () {
                openAlertBox(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

openAlertBox(context) {
  double defaultSize = SizeConfig.defaultSize;
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
                  "Thêm sản phẩm:",
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
                    controller: context.read<OrderViewModel>().addNewOrder,
                    decoration: InputDecoration(
                      hintText: "Thêm nội dung",
                      border: InputBorder.none,
                    ),
                    maxLines: 10,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<OrderViewModel>().addOrder();
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
                                  "Thêm thông tin",
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
