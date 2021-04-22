import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPeopleCreate extends StatefulWidget {
  @override
  _FindPeopleCreateState createState() => _FindPeopleCreateState();
}

class _FindPeopleCreateState extends State<FindPeopleCreate> {
  int selectedIndex = 0;

  List<bool> _isChecked;
  List<int> _texts;

  @override
  void initState() {
    super.initState();
    _texts = context.read<OrderViewModel>().getListUserCreate();
    _texts.insert(0, 0);
    var count = 0;
    List<int> listFindPeople = context.read<OrderViewModel>().listFindPeople;

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
    OrderViewModel provider = context.watch<OrderViewModel>();
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primary,
            centerTitle: true,
            title: Text("Người tạo đơn"),
            actions: <Widget>[
              FlatButton(
                textColor: primary,
                onPressed: () {
                  List<int> find = [];
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
                  provider.findOrder();
                  Navigator.pop(context);
                },
                child: Text("Apply",
                    style: TextStyle(
                        fontSize: defaultSize * 1.4,
                        color: white,
                        fontWeight: FontWeight.w300)),
                shape: CircleBorder(side: BorderSide(color: transparent)),
              ),
            ]),
        body: ListView.builder(
          itemCount: _texts.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(getValueIndex(index, provider)),
              value: _isChecked[index],
              onChanged: (val) {
                setState(
                  () {
                    if (index == 0) {
                      for (var i = 0; i < _texts.length; i++) {
                        _isChecked[i] = val;
                      }
                    }
                    if (index != 0 && val == false) {
                      _isChecked[0] = false;
                    }
                    _isChecked[index] = val;
                  },
                );
              },
            );
          },
        ));
  }

  getValueIndex(index, OrderViewModel provider) {
    UserViewModel providerUser = context.watch<UserViewModel>();
    if (index == 0) {
      return "Tất cả";
    }
    if (index == 1 && provider.getMe == _texts[index]) {
      return "${providerUser.getUserByUser(_texts[index]).name} (Tôi)";
    }
    return providerUser.getUserByUser(_texts[index]).name;
  }
}
