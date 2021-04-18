import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFieldCommon extends StatelessWidget {
  final String initialValue, hintText, prefix;
  final TextEditingController controller;
  final Color textColor;
  final double margin;
  final Widget suffix, prefixWidget, prefixIcon;
  final bool isEmail,
      isPhone,
      isEnabled,
      isPassword,
      isMoney,
      isDark,
      isTextArea,
      autofocus;
  final VoidCallback onTap;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function() onEditingComplete;
  const TextFieldCommon({
    Key key,
    this.initialValue,
    this.prefix,
    this.controller,
    this.onTap,
    this.hintText,
    this.isEmail = false,
    this.isEnabled = true,
    this.isTextArea = true,
    this.margin = 30,
    this.isPhone = false,
    this.isPassword = false,
    this.isDark = false,
    this.isMoney = false,
    this.autofocus = false,
    this.textColor = Colors.black,
    this.suffix,
    this.prefixWidget,
    this.prefixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextFormField(
              initialValue: controller == null ? initialValue : null,
              controller: controller,
              obscureText: isPassword,
              enabled: isEnabled,
              validator: validator,
              onChanged: onChanged,
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              autofocus: autofocus,
              maxLines: isTextArea && !isPassword
                  ? null
                  : isPassword
                      ? 1
                      : 3,
              keyboardType: isEmail
                  ? TextInputType.emailAddress
                  : isPhone
                      ? TextInputType.phone
                      : isMoney
                          ? TextInputType.numberWithOptions()
                          : TextInputType.text,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                  color: isDark ? Colors.white : textColor),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                fillColor: isDark ? black.withOpacity(0.5) : hover_ms,
                hintText: hintText,
                prefixText: prefix,
                prefix: prefixWidget,
                prefixIcon: prefixIcon,
                suffix: suffix,
                errorStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: isDark ? Colors.white : Colors.red),
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: isDark
                        ? Colors.white.withOpacity(0.9)
                        : textColor.withOpacity(0.4)),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: isDark ? primary : Colors.red,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: isDark ? Colors.amber : Colors.red[400],
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: isDark ? Colors.amber : Colors.red[400],
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: isDark ? primary : Colors.grey[200],
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: isDark ? primary : Colors.grey[200],
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: isDark ? primary : Colors.grey[100],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
