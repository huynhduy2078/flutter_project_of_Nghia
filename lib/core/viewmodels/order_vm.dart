import 'dart:js';
import 'dart:math';

import 'package:chat_messanger_ui/core/models/buyer_model.dart';
import 'package:chat_messanger_ui/core/models/order_model.dart';
import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:chat_messanger_ui/core/models/status_model.dart';
import 'package:chat_messanger_ui/core/network_layer/helper/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import 'history_vm.dart';
import 'product_vm.dart';

class OrderViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  final apiHelper = ApiHelper();
  var isMe = 5;

  int get getMe => isMe;

  List<Order> _order = [];
  List<Order> get order => _order;

  set order(List<Order> val) {
    _order = val;
    notifyListeners();
  }

  List<Order> _orderFind = [];
  List<Order> get orderFind => _orderFind;

  set orderFind(List<Order> val) {
    _orderFind = val;
    notifyListeners();
  }

  List<int> _listFindPeople = [];
  List<int> get listFindPeople => _listFindPeople;

  set listFindPeople(List<int> val) {
    _listFindPeople = val;
    notifyListeners();
  }

  int _findStatus = 0;
  int get findStatus => _findStatus;

  set findStatus(int val) {
    _findStatus = val;
    notifyListeners();
  }

  List<DateTime> _date = [
    DateTime(2018, 1, 1),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
  ];

  List<DateTime> get dateFiter => _date;

  set dateFiter(List<DateTime> val) {
    _date[0] = val[0];
    _date[1] = DateTime(val[1].year, val[1].month, val[1].day + 1);
    notifyListeners();
  }

  bool _isFind = false;
  bool get isFind => _isFind;

  set isFind(bool val) {
    _isFind = val;
    notifyListeners();
  }

  bool _isShowFind = false;
  bool get showFind => _isShowFind;

  set showFind(bool val) {
    _isShowFind = val;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final TextEditingController addNewOrder = new TextEditingController();
  final TextEditingController textSearch = new TextEditingController();

  addOrder() {
    try {
      // final response = await apiHelper.get(
      //   url: '',
      // );
      isLoading = true;
      if (true) {
        int id = new Random().nextInt(1000);
        int userCreate = isMe;
        order.insert(
          0,
          Order(
            id: id,
            idUser: userCreate,
            status: 1,
            content: addNewOrder.text,
            dateCreate: DateTime.now(),
          ),
        );

        var viewmodels = HistoryViewModel();

        viewmodels.addHistorynewOrder(id, userCreate, addNewOrder.text);
      }
      addNewOrder.text = '';
      isLoading = false;
      findOrder();
    } catch (e) {
      print(e);
    }
  }

  showAllOrder() {
    order = listOrder;
  }

  getColorItem(status) {
    Color color;
    listStatus.forEach((st) {
      if (st.id == status) {
        color = st.color;
        return;
      }
    });
    return color;
  }

  findOrder() {
    List<Order> _orderFind = [];
    isLoading = true;
    isFind = true;
    bool isHaveFindPeople = listFindPeople.length > 0;
    if (isHaveFindPeople) {
      listOrder.forEach((order) {
        listFindPeople.forEach((people) {
          if (order.idUser == people) {
            _orderFind.add(order);
          }
        });
      });
      orderFind = _orderFind;
    }
    if (findStatus > 0) {
      orderFind = (isHaveFindPeople ? orderFind : listOrder)
          .where((order) => (order.status == findStatus))
          .toList();
    }

    if (textSearch.text.length != 0) {
      orderFind = ((isHaveFindPeople || findStatus > 0) ? orderFind : listOrder)
          .where((order) => (order.content.contains(textSearch.text) ||
              order.id.toString().contains(textSearch.text)))
          .toList();
    }
    if (isChangeDate()) {
      orderFind =
          ((isHaveFindPeople || findStatus > 0 || textSearch.text.length != 0)
                  ? orderFind
                  : listOrder)
              .where((order) => (order.dateCreate.millisecondsSinceEpoch >=
                      dateFiter[0].millisecondsSinceEpoch &&
                  order.dateCreate.millisecondsSinceEpoch <=
                      dateFiter[1].millisecondsSinceEpoch))
              .toList();
    }

    if (!isHaveFindPeople &&
        findStatus <= 0 &&
        textSearch.text.length == 0 &&
        !isChangeDate()) {
      isFind = false;
      orderFind = order;
    }

    isLoading = false;
  }

  getNumberPeopleCreate() {
    List<int> listAllUser = getListUserCreate();
    if (listFindPeople.length == listAllUser.length) {
      return "Tất cả";
    }
    if (listFindPeople.length == 1) {
      if (listFindPeople[0] == isMe) {
        return "Chỉ mình tôi";
      }
      return listFindPeople[0];
    }
    if (listFindPeople.length > 0) {
      if (listFindPeople.contains(isMe)) {
        return "Bạn và ${listFindPeople.length - 1} user khác";
      }
      return "${listFindPeople.length} user khác";
    }
    return "Tất cả";
  }

  getListUserCreate() {
    List<int> listAll = [];
    for (int i = 0; i < listOrder.length; i++) {
      Order order = listOrder[i];
      if (order.idUser != null) {
        listAll.add(order.idUser);
      }
    }
    if (listAll.contains(isMe)) {
      listAll.insert(0, isMe);
    }
    return [
      ...{...listAll}
    ];
  }

  bool isChangeDate() {
    Function deepEq = const DeepCollectionEquality().equals;
    List<DateTime> date = [
      DateTime(2018, 1, 1),
      DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
    ];
    return !deepEq(dateFiter, date);
  }

  StatusModel getStatusById(int id) {
    StatusModel status = listStatus[listStatus.length - 1];
    listStatus.forEach((st) {
      if (st.id == id) {
        status = st;
        return;
      }
    });
    return status;
  }

  List<StatusModel> getStatusByUpdate(int id) {
    return listStatus.where((st) => (st.id != id && st.id != 0)).toList();
  }

  bool updateStatus(int idOrder, int idStatus) {
    Order od = listOrder.firstWhere((order) => (order.id == idOrder),
        orElse: () => null);
    int index = listOrder.indexWhere((order) => order.id == idOrder);
    List<Order> list = listOrder;
  }

  double getMoneyBill(id) {
    double totalBill = 0;
    List<Order> order = listOrder
        .where((order) => (order.id == id && order.product.length > 0))
        .toList();
    if (order.length == 1) {
      var productView = ProductViewModel();
      var productBuyed = order[0].product;
      if (productBuyed.length > 0) {
        productBuyed.forEach((p) {
          Product product = productView.getProductById(p.keys.toList()[0]);
          totalBill = totalBill + product.price * p.values.toList()[0];
        });
      }
    }
    return totalBill;
  }

  // Demo list
  List<Order> listOrder = [
    Order(
        id: 1,
        idUser: 1,
        status: 3,
        content: 'bbbbbbbbbbbb',
        dateCreate: DateTime(2021, 4, 18, 23, 10, 22),
        buyer: BuyerModel(),
        product: [
          {1: 1},
          {3: 2},
          {4: 2}
        ]),
    Order(
      id: 2,
      idUser: 5,
      status: 4,
      content: 'ccccccccccccccc',
      dateCreate: DateTime(2021, 4, 18, 22, 11, 10),
      buyer: BuyerModel(
          name: "Trần văn Bo",
          numberPhone: '091233123131',
          address: '180 Lý thừa  dụ',
          note: 'Khách hàng bị ngu'),
      product: [],
    ),
    Order(
      id: 3,
      idUser: 2,
      status: 2,
      content: 'hello',
      dateCreate: DateTime(2021, 4, 17, 22, 11, 10),
      buyer: BuyerModel(
        name: "Lý văn Tèo",
        numberPhone: '0922711231',
        address: 'Mẹ thứ, Tam kỳ , Quảng Nam',
      ),
      product: [
        {2: 2},
        {4: 20},
      ],
    ),
    Order(
      id: 4,
      idUser: 5,
      status: 1,
      content:
          'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      dateCreate: DateTime(2021, 3, 17, 22, 11, 10),
      buyer: BuyerModel(),
      product: [],
    ),
  ];

  List<StatusModel> listStatus = [
    //id = 0 of All
    StatusModel(id: 0, status: "ALL", color: Color(0xFF66B2BA)),
    StatusModel(id: 1, status: "NEW", color: Color(0xFF3F51B5)),
    StatusModel(id: 2, status: "UPDATE", color: Color(0xFFFFC107)),
    StatusModel(id: 3, status: "CONFIRMED", color: Color(0xFFFF5722)),
    StatusModel(id: 4, status: "CONFIRMING", color: Color(0xFFF2575B)),
    StatusModel(id: 5, status: "DONE", color: Color(0xFF4CAF50)),
    StatusModel(id: 6, status: "CANCEL", color: Color(0xFF9C27B0)),
    StatusModel(id: 7, status: "OTHER", color: Color(0xFFE91E63)),
  ];
}
