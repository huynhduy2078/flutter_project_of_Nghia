import 'package:flutter/material.dart';

import 'buyer_model.dart';
import 'history_model.dart';

class Products {
  final int id;
  final String userCreate, status, content, note, dateCreate;
  final HistoryModel history;
  final BuyerModel buyer;

  Products({
    this.id,
    this.userCreate,
    this.status,
    this.content,
    this.note,
    this.dateCreate,
    this.history,
    this.buyer,
  });
}
