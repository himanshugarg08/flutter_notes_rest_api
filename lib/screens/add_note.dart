import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Backend/backend_service.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:flutter_rest_api/models/note_create_model.dart';
import 'package:flutter_rest_api/screens/home_page.dart';
import 'package:flutter_rest_api/widgets/custom_button.dart';
import 'package:flutter_rest_api/widgets/input_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scalify/scalify.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _noteContent = TextEditingController();
  final TextEditingController _noteTitle = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String buttonText = "Save";
  bool isButtonActive = true;

  void saveNote() async {
    setState(() {
      buttonText = "Saving";
      isButtonActive = false;
    });
    final note = NoteCreate(
        noteTitle: _noteTitle.text.capitalize(),
        noteContent: _noteContent.text.capitalize());
    bool isNoteCreated = await BackendService.saveNotes(note);

    if (isNoteCreated) {
      setState(() {
        buttonText = "Saved";
        isButtonActive = true;
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const HomePage();
      }), (route) => false);
    } else {
      setState(() {
        buttonText = "Something Went Wrong!";
        isButtonActive = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(of: 2.5),
                  Text("Add Note",
                      style: Theme.of(context).textTheme.headline3),
                  if (isKeyBoard) const VerticalSpacing(of: 6),
                  const VerticalSpacing(of: 6),
                  Center(
                    child: SizedBox(
                      height: !isKeyBoard ? 12.h : 20.h,
                      width: 60.w,
                      child: SvgPicture.asset('assets/add_notes.svg'),
                    ),
                  ),
                  if (isKeyBoard) const VerticalSpacing(of: 6),
                  const VerticalSpacing(of: 6),
                  InputContainer(
                      label: "Title", maxLines: 1, textController: _noteTitle),
                  const VerticalSpacing(of: 2),
                  InputContainer(
                      label: "Content",
                      maxLines: 4,
                      textController: _noteContent),
                  const VerticalSpacing(of: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        width: 90.w,
        buttonLabel: buttonText,
        buttonAction: () {
          if (isButtonActive) {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              saveNote();
            }
          }
        },
      ),
    );
  }
}
