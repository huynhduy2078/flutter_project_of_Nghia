import 'dart:math' as math;
import 'package:chat_messanger_ui/constant/evenSelectMessage.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform/platform.dart';

enum PressType {
  longPress,
  singleClick,
}

class CustomPopupMenuController extends ChangeNotifier {
  bool menuIsShowing = false;

  void showMenu() {
    menuIsShowing = true;
    notifyListeners();
  }

  void hideMenu() {
    menuIsShowing = false;
    notifyListeners();
  }

  void toggleMenu() {
    menuIsShowing = !menuIsShowing;
    notifyListeners();
  }
}

class CustomPopupMenu extends StatefulWidget {
  CustomPopupMenu({
    this.child,
    this.pressType,
    this.onChangeIcon,
    this.arrowColor = const Color(0xFF4C4C4C),
    this.showArrow = true,
    this.barrierColor = Colors.black12,
    this.arrowSize = 10.0,
    this.horizontalMargin = 10.0,
    this.verticalMargin = 10.0,
    this.controller,
    this.onShowIcon,
    this.onChangeAction,
    this.listEventIcon,
  });

  final Widget child;
  final PressType pressType;
  final bool showArrow;
  final Color arrowColor;
  final Color barrierColor;
  final double horizontalMargin;
  final double verticalMargin;
  final double arrowSize;
  final List listEventIcon;
  final ValueChanged<int> onChangeIcon;
  final ValueChanged<int> onChangeAction;
  final ValueChanged<bool> onShowIcon;
  final CustomPopupMenuController controller;
  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  RenderBox _childBox;
  RenderBox _parentBox;
  OverlayEntry _overlayEntry;
  CustomPopupMenuController _controller;

  _showMenu() {
    Widget arrow = ClipPath(
      child: Container(
        width: widget.arrowSize,
        height: widget.arrowSize,
        color: widget.arrowColor,
      ),
      clipper: _ArrowClipper(),
    );
    widget.onShowIcon(true);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height - 80),
                  child: GestureDetector(
                    onTap: () => _hideMenu(),
                    child: Container(
                      color: widget.barrierColor,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  color: white,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listEventAction.length < 3
                          ? listEventAction
                              .map(
                                (item) => FlatButton(
                                  onPressed: () {
                                    _hideMenu();
                                    widget.onChangeAction(item['id']);
                                  },
                                  child: Text(
                                    item['title'],
                                    textAlign: TextAlign.justify,
                                    style:
                                        TextStyle(color: black, fontSize: 15),
                                  ),
                                ),
                              )
                              .toList()
                          : [
                              FlatButton(
                                onPressed: () {
                                  _hideMenu();
                                  widget
                                      .onChangeAction(listEventAction[0]['id']);
                                },
                                child: Text(
                                  listEventAction[0]['title'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(color: black, fontSize: 15),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  _hideMenu();
                                  widget
                                      .onChangeAction(listEventAction[1]['id']);
                                },
                                child: Text(
                                  listEventAction[1]['title'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(color: black, fontSize: 15),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  _hideMenu();
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoActionSheet(
                                      actions: listEventAction
                                          .map((item) =>
                                              CupertinoActionSheetAction(
                                                child: Text(
                                                  item['title'],
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      color: black,
                                                      fontSize: 15),
                                                ),
                                                onPressed: () {
                                                  widget.onChangeAction(
                                                      item['id']);
                                                  Navigator.pop(context);
                                                },
                                              ))
                                          .skip(2)
                                          .toList(),
                                      cancelButton: CupertinoActionSheetAction(
                                        child: Text(
                                          "Hủy",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: black, fontSize: 15),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Khác...",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(color: black, fontSize: 15),
                                ),
                              ),
                            ]),
                )
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: _parentBox.size.width - 2 * widget.horizontalMargin,
                minWidth: 0,
              ),
              child: CustomMultiChildLayout(
                delegate: _MenuLayoutDelegate(
                  anchorSize: _childBox.size,
                  anchorOffset: _childBox.localToGlobal(
                    Offset(-widget.horizontalMargin, 0),
                  ),
                  verticalMargin: widget.verticalMargin,
                ),
                children: <Widget>[
                  if (widget.showArrow)
                    LayoutId(
                      id: _MenuLayoutId.arrow,
                      child: arrow,
                    ),
                  if (widget.showArrow)
                    LayoutId(
                      id: _MenuLayoutId.downArrow,
                      child: Transform.rotate(
                        angle: math.pi,
                        child: arrow,
                      ),
                    ),
                  LayoutId(
                    id: _MenuLayoutId.content,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Material(
                          child: ClipRRect(
                            child: Container(
                              width: 300,
                              //color: const Color(0xFF4C4C4C),
                              color: Colors.transparent,

                              child: Column(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: GridView.count(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        crossAxisCount: 6,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: widget.listEventIcon
                                            .map((item) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .translucent,
                                                      onTap: () => {
                                                        widget.onChangeIcon(
                                                            item["id"]),
                                                        _hideMenu(),
                                                      },
                                                      child: Image.asset(
                                                        item["iconGif"],
                                                        width: 40.0,
                                                        height: 40.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
    if (_overlayEntry != null) {
      print(_overlayEntry);
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  _hideMenu() {
    print(_overlayEntry);
    if (_overlayEntry != null) {
      widget.onShowIcon(false);
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  _updateView() {
    if (_controller?.menuIsShowing ?? false) {
      _showMenu();
    } else {
      _hideMenu();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    if (_controller == null) _controller = CustomPopupMenuController();
    _controller?.addListener(_updateView);
    WidgetsBinding.instance?.addPostFrameCallback((call) {
      _childBox = context.findRenderObject() as RenderBox;
      _parentBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    });
  }

  @override
  void dispose() {
    _hideMenu();
    _controller?.removeListener(_updateView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Material(
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: widget.child,
        onTap: () {
          if (widget.pressType == PressType.singleClick) {
            _showMenu();
          }
        },
        onLongPress: () {
          if (widget.pressType == PressType.longPress) {
            _showMenu();
          }
        },
      ),
      color: Colors.transparent,
    );

    if (Platform.isIOS) {
      return child;
    } else {
      return WillPopScope(
        onWillPop: () {
          _hideMenu();
          return Future.value(true);
        },
        child: child,
      );
    }
  }
}

enum _MenuLayoutId {
  arrow,
  downArrow,
  content,
}

enum _MenuPosition {
  bottomLeft,
  bottomCenter,
  bottomRight,
  topLeft,
  topCenter,
  topRight,
}

class _MenuLayoutDelegate extends MultiChildLayoutDelegate {
  _MenuLayoutDelegate({
    this.anchorSize,
    this.anchorOffset,
    this.verticalMargin,
  });

  final Size anchorSize;
  final Offset anchorOffset;
  final double verticalMargin;
  @override
  void performLayout(Size size) {
    Size contentSize = Size.zero;
    Size arrowSize = Size.zero;
    Offset contentOffset = Offset(0, 0);
    Offset arrowOffset = Offset(0, 0);

    double anchorCenterX = anchorOffset.dx + anchorSize.width / 2;
    double anchorTopY = anchorOffset.dy;
    double anchorBottomY = anchorTopY + anchorSize.height;
    _MenuPosition menuPosition = _MenuPosition.bottomCenter;

    if (hasChild(_MenuLayoutId.content)) {
      contentSize = layoutChild(
        _MenuLayoutId.content,
        BoxConstraints.loose(size),
      );
    }
    if (hasChild(_MenuLayoutId.arrow)) {
      arrowSize = layoutChild(
        _MenuLayoutId.arrow,
        BoxConstraints.loose(size),
      );
    }
    if (hasChild(_MenuLayoutId.downArrow)) {
      layoutChild(
        _MenuLayoutId.downArrow,
        BoxConstraints.loose(size),
      );
    }

    bool isTop = false;
    if (anchorBottomY + verticalMargin + arrowSize.height + contentSize.height >
        size.height) {
      isTop = true;
    }
    if (anchorCenterX - contentSize.width / 2 < 0) {
      menuPosition = isTop ? _MenuPosition.topLeft : _MenuPosition.bottomLeft;
    } else if (anchorCenterX + contentSize.width / 2 > size.width) {
      menuPosition = isTop ? _MenuPosition.topRight : _MenuPosition.bottomRight;
    } else {
      menuPosition =
          isTop ? _MenuPosition.topCenter : _MenuPosition.bottomCenter;
    }

    switch (menuPosition) {
      case _MenuPosition.bottomCenter:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorBottomY + verticalMargin,
        );
        contentOffset = Offset(
          anchorCenterX - contentSize.width / 2,
          anchorBottomY + verticalMargin + arrowSize.height,
        );
        break;
      case _MenuPosition.bottomLeft:
        arrowOffset = Offset(anchorCenterX - arrowSize.width / 2,
            anchorBottomY + verticalMargin);
        contentOffset = Offset(
          0,
          anchorBottomY + verticalMargin + arrowSize.height,
        );
        break;
      case _MenuPosition.bottomRight:
        arrowOffset = Offset(anchorCenterX - arrowSize.width / 2,
            anchorBottomY + verticalMargin);
        contentOffset = Offset(
          size.width - contentSize.width,
          anchorBottomY + verticalMargin + arrowSize.height,
        );
        break;
      case _MenuPosition.topCenter:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height,
        );
        contentOffset = Offset(
          anchorCenterX - contentSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height - contentSize.height,
        );
        break;
      case _MenuPosition.topLeft:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height,
        );
        contentOffset = Offset(
          0,
          anchorTopY - verticalMargin - arrowSize.height - contentSize.height,
        );
        break;
      case _MenuPosition.topRight:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height,
        );
        contentOffset = Offset(
          size.width - contentSize.width,
          anchorTopY - verticalMargin - arrowSize.height - contentSize.height,
        );
        break;
    }
    if (hasChild(_MenuLayoutId.content)) {
      positionChild(_MenuLayoutId.content, contentOffset);
    }
    bool isBottom = false;
    if (_MenuPosition.values.indexOf(menuPosition) < 3) {
      // bottom
      isBottom = true;
    }
    if (hasChild(_MenuLayoutId.arrow)) {
      positionChild(
        _MenuLayoutId.arrow,
        isBottom
            ? Offset(arrowOffset.dx, arrowOffset.dy + 0.1)
            : Offset(-100, 0),
      );
    }
    if (hasChild(_MenuLayoutId.downArrow)) {
      positionChild(
        _MenuLayoutId.downArrow,
        !isBottom
            ? Offset(arrowOffset.dx, arrowOffset.dy - 0.1)
            : Offset(-100, 0),
      );
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
