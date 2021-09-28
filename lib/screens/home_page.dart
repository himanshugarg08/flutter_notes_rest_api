import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:scalify/scalify.dart';

import '../widgets/notes_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    /*required this.customTheme*/
  }) : super(key: key);

  //final CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    Scalify.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacing(of: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notes", style: Theme.of(context).textTheme.headline3),
                ],
              ),
              const VerticalSpacing(of: 2),
              const Expanded(child: NotesList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => addDialogCall(context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Dialog addDialogCall(BuildContext context) {
  final buttonLabel = "Save";

  Dialog addDialog = Dialog(
    backgroundColor: Colors.white,
    elevation: 0.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      width: 100.w,
      color: kDarkColor,
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(),
          Text("Add Note:", style: Theme.of(context).textTheme.headline5),
          const VerticalSpacing(of: 2),
          const InputContainer(label: "Title", maxLines: 1),
          const VerticalSpacing(of: 2),
          const InputContainer(label: "Content", maxLines: 4),
          const VerticalSpacing(of: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CustomButton(buttonLabel: "Cancel"),
              HorizontalSpacing(of: 3),
              CustomButton(buttonLabel: "Save"),
            ],
          ),
          const VerticalSpacing(),
        ],
      ),
    ),
  );
  return addDialog;
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonLabel,
  }) : super(key: key);

  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      elevation: 0,
      height: 5.h,
      color: Theme.of(context).primaryColor,
      child: Text(buttonLabel,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              )),
    );
  }
}

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffedf1f3),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: TextField(
        style:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: kDarkColor),
        maxLines: maxLines,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: const Color(0xffbbc0c9), fontWeight: FontWeight.bold),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
