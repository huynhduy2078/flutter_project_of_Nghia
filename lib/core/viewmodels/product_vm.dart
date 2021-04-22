import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  Product getProductById(int id) {
    print(id);
    var product;
    listProduct.forEach((pd) {
      if (pd.id == id) {
        product = pd;
        return;
      }
    });
    return product;
  }

  List<Product> listProduct = [
    Product(
        id: 1,
        name: "Bánh trung thu hảo hạng loại 1 - Ăn vào là ghiền",
        price: 20000,
        profilePicUrl: "assets/images/pic.jpg"),
    Product(
        id: 2,
        name:
            "Nước uống đẹp da kinohimitsu collagen diamond 5300 hộp 3 chai 50ml",
        price: 300000,
        profilePicUrl: "assets/images/pic.jpg"),
    Product(
        id: 3,
        name:
            "Băng cá nhân không thấm nước waterproof plaster, 2 size, 12 miếng/hộp",
        price: 20900,
        profilePicUrl: "assets/images/pic.jpg"),
    Product(
        id: 4,
        name:
            "Mascara chân mày lilybyred skinny mes brow mascara 3 (3.5g) - dark brown '' (cây)",
        price: 163800,
        profilePicUrl: "assets/images/pic.jpg"),
    Product(
        id: 5,
        name:
            "Bút kẻ mắt nước lilybyred am9 to pm9 survival penliner 1 (0.6g) - matt black '' (cây)",
        price: 182000,
        profilePicUrl: "assets/images/pic.jpg"),
    Product(
        id: 6,
        name: "Black rouge cheek-on b01 26.9 gram",
        price: 193700,
        profilePicUrl: "assets/images/pic.jpg"),
  ];
}
