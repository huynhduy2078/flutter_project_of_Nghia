import 'package:chat_messanger_ui/core/models/buyer_model.dart';
import 'package:chat_messanger_ui/core/models/history_model.dart';
import 'package:chat_messanger_ui/core/models/product_model.dart';
import 'package:chat_messanger_ui/core/network_layer/helper/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  final apiHelper = ApiHelper();
  var isMe = "Huynhduy281096@gmail.com";

   String get getMe => isMe;


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

  List<String> _listFindPeople = [];
  List<String> get listFindPeople => _listFindPeople;

  set listFindPeople(List<String> val) {
    _listFindPeople = val;
    notifyListeners();
  }

  bool _isFind = false;
  bool get isFind => _isFind;

  set isFind(bool val) {
    _isFind = val;
    notifyListeners();
  }

  final TextEditingController addNewProduct = new TextEditingController();
  final TextEditingController textSearch = new TextEditingController();

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

  searchProduct() {
    List<Products> _productsFind = [];
    isLoading = true;
    if (textSearch.text.length != 0) {
      isFind = true;
      products.forEach((product) {
        if (product.content.contains(textSearch.text) ||
            product.id.toString().contains(textSearch.text)) {
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

  findProduct() {
    List<Products> _productsFind = [];
    isLoading = true;
    if (listFindPeople.length > 0) {
      listProduct.forEach((product) {
        listFindPeople.forEach((people) {
          if (product.userCreate == people) {
            _productsFind.add(product);
          }
        });
      });
      productsFind = _productsFind;
      isFind = true;
    } else {
      isFind = false;
      productsFind = products;
    }
    isLoading = false;
  }

  getNumberPeopleCreate() {
    List<String> listAllUser = getListUserCreate();
    if (listFindPeople.length == listAllUser.length) {
      return "Tất cả";
    }
    if (listFindPeople.length == 1) {
      if (listFindPeople[0] == isMe) {
        return "Chỉ mình bạn";
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
    List<String> listAll = [];
    for (int i = 0; i < listProduct.length; i++) {
      Products product = listProduct[i];
      if (product.userCreate != null) {
        listAll.add(product.userCreate);
      }
    }
    if (listAll.contains(isMe)) {
      listAll.insert(0, isMe);
    }
    return [
      ...{...listAll}
    ];
  }

  // Demo list
  List<Products> listProduct = [
    Products(
      id: 2,
      userCreate: "Huunghia8896@gmail.com",
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
    Products(
      id: 3,
      userCreate: "ThanhNguyen@gmail.com",
      status: "CONFIRMING",
      content: 'hello',
      note: '',
      dateCreate: DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
      history: HistoryModel(),
      buyer: BuyerModel(),
    ),
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
  ];
}
