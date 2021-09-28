import 'package:flutter/material.dart';
import 'package:flutter_rest_api/widgets/custom_button.dart';
import 'package:flutter_rest_api/widgets/input_container.dart';
import 'package:scalify/scalify.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  void saveNote() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacing(of: 4),
              Text("Add Note", style: Theme.of(context).textTheme.headline3),
              const VerticalSpacing(of: 8),
              Center(
                child: Container(
                  height: 25.h,
                  width: 60.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/add_notes.png"),
                  ),
                ),
              ),
              const VerticalSpacing(of: 8.5),
              const InputContainer(label: "Title", maxLines: 1),
              const VerticalSpacing(of: 2),
              const InputContainer(label: "Content", maxLines: 4),
              const Expanded(child: VerticalSpacing(of: 2)),
              CustomButton(
                buttonLabel: "Save",
                buttonAction: () {},
              ),
              const VerticalSpacing(of: 5),
            ],
          ),
        ),
      ),
    );
  }
}
