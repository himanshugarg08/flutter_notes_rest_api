import 'package:flutter/material.dart';
import 'package:scalify/scalify.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonLabel,
    required this.buttonAction,
  }) : super(key: key);

  final String buttonLabel;
  final VoidCallback buttonAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Center(
        child: Container(
          height: 6.h,
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child:
                Text(buttonLabel, style: Theme.of(context).textTheme.headline6),
          ),
        ),
      ),
    );
  }
}
