import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/margin.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:chat_messanger_ui/widget/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_messanger_ui/utils/navigator.dart';
import 'package:chat_messanger_ui/core/viewmodels/order_vm.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'find_user_create.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  double defaultSize = SizeConfig.defaultSize;
  int selectedIndex = 0;
  DateTime startDate = DateTime(2018, 1);
  DateTime endDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    OrderViewModel provider = context.watch<OrderViewModel>();
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
        decoration: BoxDecoration(
          color: primary,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
          child: Column(
            children: [
              buildPepleCreate(),
              buildDateCreate(),
              YMargin(defaultSize * 0.5),
              buildCategoriComponent(provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoriComponent(OrderViewModel provider) {
    return SizedBox(
      height: SizeConfig.defaultSize * 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.listStatus.length,
        itemBuilder: (context, index) =>
            buildCategoriItem(index, context, provider),
      ),
    );
  }

  Widget buildCategoriItem(
      int index, BuildContext context, OrderViewModel provider) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        provider.findStatus = provider.listStatus[index].id;
        provider.findOrder();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: SizeConfig.defaultSize * 2,
            right: SizeConfig.defaultSize * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2, //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color: selectedIndex == index ? primaryLignt : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 0.5,
            )),
        child: Text(
          provider.listStatus[index].status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      ),
    );
  }

  Widget buildPepleCreate() {
    return GestureDetector(
      onTap: () => context.navigate(FindPeopleCreate()),
      child: Container(
        height: SizeConfig.defaultSize * 3,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: SizeConfig.defaultSize * 2,
            right: SizeConfig.defaultSize * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Người tạo đơn:",
              style: TextStyle(
                color: white,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Text(
                  context.read<OrderViewModel>().getNumberPeopleCreate(),
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                  ),
                ),
                XMargin(defaultSize),
                SvgPicture.asset("assets/icons/arrow_right.svg",
                    height: 13, width: 13, color: white),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDateCreate() {
    return GestureDetector(
      onTap: () => _selectDate(context, true),
      child: Container(
        height: SizeConfig.defaultSize * 4,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: SizeConfig.defaultSize * 2,
            right: SizeConfig.defaultSize * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ngày tạo đơn:",
              style: TextStyle(
                color: white,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                TextButton(
                    child: Text(
                      "Từ: ${getTextDate(true, startDate)}",
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () => _selectDate(context, true)),
                XMargin(defaultSize * 2),
                TextButton(
                    child: Text(
                      "Đến: ${getTextDate(false, endDate)}",
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () => _selectDate(context, false)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime selectedDate;
    final DateTime picked = await showDatePicker(
        helpText: isStart ? "Select date start:" : "Select date end:",
        context: context,
        initialDate: isStart ? startDate : endDate,
        firstDate: DateTime(2018, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(
        () {
          var _startDate = startDate, _endStartDate = endDate;

          if (isStart) {
            _startDate = picked;
          } else {
            _endStartDate = picked;
          }
          if (startDate.millisecondsSinceEpoch >
              endDate.millisecondsSinceEpoch) {
            _startDate = endDate;
          }
          startDate = _startDate;
          endDate = _endStartDate;
        },
      );
    context.read<OrderViewModel>().dateFiter = [startDate, endDate];
    context.read<OrderViewModel>().findOrder();
  }

  getTextDate(isStart, date) {
    var format = new DateFormat('dd/MM/y');
    DateTime now = DateTime.now();
    if (isStart && date == DateTime(2018, 1, 1)) return "Quá khứ";
    if (date == DateTime(now.year, now.month, now.day)) return "Hôm nay";
    if (date == DateTime(now.year, now.month, now.day - 1)) return "Hôm qua";
    return format.format(date);
  }
}
