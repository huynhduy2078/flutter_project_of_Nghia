import 'package:chat_messanger_ui/core/models/buyer_model.dart';
import 'package:chat_messanger_ui/core/models/history_model.dart';
import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:chat_messanger_ui/core/network_layer/helper/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  final apiHelper = ApiHelper();

  List<Products> _products = [];
  List<Products> get products => _products;

  set products(List<Products> val) {
    _products = val;
  }

  List<Products> _productsFind = [];
  List<Products> get productsFind => _productsFind;

  set productsFind(List<Products> val) {
    _productsFind = val;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool _isFind = false;
  bool get isFind => _isFind;

  set isFind(bool val) {
    _isFind = val;
    notifyListeners();
  }

  final TextEditingController addNewProduct = new TextEditingController();

  addProduct() async {
    try {
      // final response = await apiHelper.get(
      //   url: '',
      // );
      isLoading = true;
      if (true) {
        products.insert(
          0,
          Products(
            id: 1,
            userCreate: "Huynhduy281096@gmail.com",
            status: "NEW",
            content: addNewProduct.text,
            note: '',
            dateCreate: DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
            history: HistoryModel(),
            buyer: BuyerModel(),
          ),
        );
      }
      addNewProduct.text = '';
      isLoading = false;
    } catch (e) {
      print(e);
    }
  }

  showAllProduct() {
    products = listProduct;
  }

  getColorItem(status) {
    var listColor = {
      'NEW': Color(0xFF8CBA19),
      'EDIT': Color(0xFFFEC037),
      'CONFIRMED': Color(0xFFAB4189),
      'CONFIRMING': Color(0xFFFE9539),
      'DONE': Color(0xFF2DBBD8),
      'CANCEL': Color(0xFFF2575B),
    };
    if (listColor[status] != null) {
      return listColor[status];
    }
    return Color(0xFF61AEC2);
  }

  findProduct(text) {
    List<Products> _productsFind = [];
    isLoading = true;
    if (text.length != 0) {
      isFind = true;
      products.forEach((product) {
        if (product.content.contains(text) ||
            product.id.toString().contains(text)) {
          _productsFind.add(product);
        }
      });
      productsFind = _productsFind;
    } else {
      isFind = false;
      productsFind = products;
    }
    isLoading = false;
  }

  // Demo list
  List<Products> listProduct = [
    Products(
      id: 1,
      userCreate: "Huynhduy281096@gmail.com",
      status: "NEW",
      content:
          'aaaaaaaaaaaaassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      note: '',
      dateCreate: DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
      history: HistoryModel(),
      buyer: BuyerModel(),
    ),
    Products(
      id: 2,
      userCreate: "Huynhduy281096@gmail.com",
      status: "EDIT",
      content: 'bbbbbbbbbbbb',
      note: '',
      dateCreate: DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
      history: HistoryModel(),
      buyer: BuyerModel(),
    ),
    Products(
      id: 3,
      userCreate: "Huynhduy281096@gmail.com",
      status: "DONE",
      content: 'ccccccccccccccc',
      note: '',
      dateCreate: DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
      history: HistoryModel(),
      buyer: BuyerModel(),
    ),
  ];
}
