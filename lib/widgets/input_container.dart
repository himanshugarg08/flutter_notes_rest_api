import 'package:flutter/material.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:scalify/scalify.dart';

class InputContainer extends StatelessWidget {
  final String label;
  final int maxLines;

  const InputContainer({
    Key? key,
    required this.label,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 90.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
        child: TextField(
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: kDarkColor),
          maxLines: maxLines,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: const Color(0xffbbc0c9), fontWeight: FontWeight.bold),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
