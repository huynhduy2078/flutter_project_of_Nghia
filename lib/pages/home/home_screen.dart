import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/pages/detailProduct/detail_screen.dart';
import 'package:chat_messanger_ui/utils/base_auth.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/widget/loader.dart';
import 'package:chat_messanger_ui/widget/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'components/Order_card.dart';
import 'components/categories.dart';
import 'components/home_header.dart';
import 'package:provider/provider.dart';
import 'package:chat_messanger_ui/utils/navigator.dart';

class HomeScreen extends StatefulWidget {
  BaseAuth auth = Auth();
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderViewModel>().showAllOrder();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    OrderViewModel provider = context.watch<OrderViewModel>();
    List<Order> order = provider.isFind ? provider.orderFind : provider.order;
    return SafeArea(
      child: Container(
        color: bg,
        child: Column(
          children: <Widget>[
            HomeHeader(),
            provider.showFind ? Categories() : YMargin(defaultSize),
            provider.isLoading
                ? Loader()
                : order.length == 0
                    ? Container()
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 0.5),
                          child: GridView.builder(
                            itemCount: order.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: SizeConfig.orientation ==
                                      Orientation.landscape
                                  ? 2
                                  : 1,
                              mainAxisSpacing: SizeConfig.defaultSize * 0.5,
                              crossAxisSpacing: SizeConfig.orientation ==
                                      Orientation.landscape
                                  ? SizeConfig.defaultSize * 2
                                  : 0,
                              childAspectRatio: 1.7,
                            ),
                            itemBuilder: (context, index) => OrderCard(
                              order: order[index],
                              press: () => context
                                  .navigate(DetailScreen(order: order[index])),
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
