import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:scalify/scalify.dart';

class InputContainer extends StatelessWidget {
  final String label;
  final int maxLines;
  final TextEditingController textController;

  const InputContainer({
    Key? key,
    required this.label,
    required this.maxLines,
    required this.textController,
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
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.6.h),
        child: TextFormField(
          controller: textController,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "$label can't be empty!";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            textController.text = value!;
          },
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
            errorStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Theme.of(context).errorColor,
                  fontSize: 12,
                ),
          ),
        ),
      ),
    );
  }
}
