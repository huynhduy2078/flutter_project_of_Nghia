import 'package:chat_messanger_ui/core/models/product_model.dart';

import 'buyer_model.dart';
import 'history_model.dart';

class Order {
  final int id, status, idUser;
  final String content;
  final DateTime dateCreate;
  final BuyerModel buyer;
  final List<Map<int, int>> product;

  Order({
    this.id,
    this.idUser,
    this.status,
    this.content,
    this.dateCreate,
    this.buyer,
    this.product,
  });
}
