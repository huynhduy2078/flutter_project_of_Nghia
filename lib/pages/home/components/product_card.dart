import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/product_vm.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  final Function press;

  const ProductCard({Key key, this.product, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var provider = ProductViewModel();
    // Now we dont this Aspect ratio
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: provider.getColorItem(product.status),
          borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Product ID: ${product.id}",
                      style: TextStyle(color: Colors.white54),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.content,
                      style: TextStyle(
                          fontSize: defaultSize * 1.8, //22
                          color: Colors.white),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultSize * 0.5), // 5
                    Text(
                      product.note,
                      style: TextStyle(color: Colors.white54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Người tạo: ${product.userCreate}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: defaultSize * 0.5), //5
                    Text(
                      "Ngày update: ${product.dateCreate}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize * 0.5), //5
          ],
        ),
      ),
    );
  }
}
