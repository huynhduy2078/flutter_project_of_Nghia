import 'package:chat_messanger_ui/core/viewmodels/product_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPeopleCreate extends StatefulWidget {
  @override
  _FindPeopleCreateState createState() => _FindPeopleCreateState();
}

class _FindPeopleCreateState extends State<FindPeopleCreate> {
  int selectedIndex = 0;

  List<bool> _isChecked;
  List<String> _texts;

  @override
  void initState() {
    super.initState();
    _texts = context.read<ProductViewModel>().getListUserCreate();
    _texts.insert(0, "Tất cả");
    var count = 0;
    List<String> listFindPeople =
        context.read<ProductViewModel>().listFindPeople;

    _isChecked = List<bool>.filled(_texts.length, false);
    if (listFindPeople.length == 0) {
      _isChecked[0] = true;
      _isChecked = List<bool>.filled(_texts.length, true);
    } else {
      for (var i = 0; i < _texts.length; i++) {
        for (var j = 0; j < listFindPeople.length; j++) {
          if (_texts[i] == listFindPeople[j]) {
            _isChecked[i] = true;
            count++;
          }
        }
      }
      if (count == _texts.length - 1) {
        _isChecked[0] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel provider = context.watch<ProductViewModel>();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: grey,
            // On Android it's false by default
            centerTitle: true,
            title: Text("Người tạo đơn"),
            actions: <Widget>[
              FlatButton(
                textColor: primary,
                onPressed: () {
                  List<String> find = [];
                  if (_isChecked.contains(true)) {
                    for (var i = 1; i < _isChecked.length; i++) {
                      if (_isChecked[i] == true) {
                        find.add(_texts[i]);
                      }
                    }
                  } else {
                    return;
                  }
                  if (find.length > 0) {
                    if (find.length == _texts.length - 1) {
                      provider.listFindPeople = [];
                    }
                    provider.listFindPeople = find;
                  }
                  provider.findProduct();
                  Navigator.pop(context);
                },
                child: Text("Apply"),
                shape:
                    CircleBorder(side: BorderSide(color: transparent)),
              ),
            ]),
        body: ListView.builder(
          itemCount: _texts.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text((index == 1 && provider.getMe == _texts[index])
                  ? "${_texts[index]} (Bạn)"
                  : _texts[index]),
              value: _isChecked[index],
              onChanged: (val) {
                if (index == 0 && val == true) {
                  setState(
                    () {
                      for (var i = 0; i < _texts.length; i++) {
                        _isChecked[i] = true;
                      }
                    },
                  );
                }
                if (index == 0 && val == false) {
                  setState(
                    () {
                      for (var i = 0; i < _texts.length; i++) {
                        _isChecked[i] = false;
                      }
                    },
                  );
                }

                if (index != 0 && val == false) {
                  setState(
                    () {
                      _isChecked[0] = false;
                    },
                  );
                }

                setState(
                  () {
                    _isChecked[index] = val;
                  },
                );
              },
            );
          },
        ));
  }
}
