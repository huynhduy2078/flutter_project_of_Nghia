import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/product_vm.dart';
import 'package:chat_messanger_ui/utils/base_auth.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/widget/loader.dart';
import 'package:chat_messanger_ui/widget/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'components/categories.dart';
import 'components/home_header.dart';
import 'package:provider/provider.dart';
import 'components/product_card.dart';

class HomeScreen extends StatefulWidget {
  BaseAuth auth = Auth();
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductViewModel>().showAllProduct();
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
    ProductViewModel provider = context.watch<ProductViewModel>();
    List<Products> product =
        provider.isFind ? provider.productsFind : provider.products;
    return SafeArea(
      child: Column(
        children: <Widget>[
          const YMargin(20),
          HomeHeader(),
          Categories(),
          provider.isLoading
              ? Loader()
              : product.length == 0
                  ? Container()
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.defaultSize * 2),
                        child: GridView.builder(
                          itemCount: product.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                SizeConfig.orientation == Orientation.landscape
                                    ? 2
                                    : 1,
                            mainAxisSpacing: 20,
                            crossAxisSpacing:
                                SizeConfig.orientation == Orientation.landscape
                                    ? SizeConfig.defaultSize * 2
                                    : 0,
                            childAspectRatio: 1.65,
                          ),
                          itemBuilder: (context, index) => ProductCard(
                            product: product[index],
                            press: () {},
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
