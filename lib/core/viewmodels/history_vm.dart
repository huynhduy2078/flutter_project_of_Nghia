import 'dart:js';

import 'package:chat_messanger_ui/core/models/history_model.dart';
import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:flutter/material.dart';

import 'order_vm.dart';

class HistoryViewModel extends ChangeNotifier {
  final TextEditingController textSearch = new TextEditingController();

  bool _showHistory = false;
  bool get showHistory => _showHistory;

  set showHistory(bool val) {
    _showHistory = val;
    notifyListeners();
  }

  List<HistoryModel> _history = [];
  List<HistoryModel> get historyData => listHistory;

  set historyData(List<HistoryModel> val) {
    listHistory = val;
    notifyListeners();
  }

  addHistorynewOrder(idOrder, idUserCreate, content) {
    try {
      if (true) {
        historyData.insert(
            0,
            HistoryModel(
                idOrder: idOrder,
                idUserCreate: idUserCreate,
                isCreate: false,
                content: content,
                dateUpdate: DateTime.now()));
      }
    } catch (e) {
      print(e);
    }
  }

  List<HistoryModel> getHistoryById(int id) {
    return historyData
        .where(
            (history) => (history.idOrder == id && history.isCreate == false))
        .toList();
  }

  HistoryModel getHistoryLassUpdate(idOrder) {
    return historyData.firstWhere((item) => (item.idOrder == idOrder),
        orElse: () => null);
  }

  List<HistoryModel> listHistory = [
    HistoryModel(
        idOrder: 1,
        idUserCreate: 1,
        isCreate: true,
        content:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Why do we use it?.",
        dateUpdate: DateTime(2021, 2, 20, 12, 11, 10)),
    HistoryModel(
        idOrder: 2,
        idUserCreate: 1,
        isCreate: true,
        content: "Lorem Ipsum is pesetting industry. ",
        dateUpdate: DateTime(2021, 2, 10, 12, 22, 10)),
    HistoryModel(
        idOrder: 1,
        idUserCreate: 1,
        isCreate: false,
        content:
            "Industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Why do we use it?.",
        dateUpdate: DateTime(2021, 2, 19, 7, 12, 0)),
    HistoryModel(
        idOrder: 1,
        idUserCreate: 2,
        isCreate: false,
        content:
            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour,",
        dateUpdate: DateTime(2021, 2, 12, 11, 02, 15)),
    HistoryModel(
        idOrder: 3,
        idUserCreate: 2,
        isCreate: true,
        content:
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots ",
        dateUpdate: DateTime(2021, 1, 14, 23, 23, 23)),
    HistoryModel(
        idOrder: 4,
        idUserCreate: 1,
        isCreate: true,
        content:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Why do we use it?.",
        dateUpdate: DateTime(2021, 2, 11, 12, 11, 10)),
  ];
}
