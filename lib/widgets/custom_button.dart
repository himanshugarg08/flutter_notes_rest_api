import 'package:flutter/material.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:scalify/scalify.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final bool invert;
  const CustomButton({
    Key? key,
    required this.buttonLabel,
    required this.buttonAction,
    required this.width,
    this.invert = false,
  }) : super(key: key);

  final String buttonLabel;
  final VoidCallback buttonAction;
  final borderWidth = 1.2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        height: 6.h - borderWidth + 0.2,
        width: width - borderWidth + 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: invert ? Colors.transparent : Theme.of(context).primaryColor,
          border: Border.all(
              width: borderWidth, color: Theme.of(context).primaryColor),
        ),
        child: Center(
          child: Text(buttonLabel,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color:
                      invert ? Theme.of(context).primaryColor : kLightColor)),
        ),
      ),
    );
  }
}
