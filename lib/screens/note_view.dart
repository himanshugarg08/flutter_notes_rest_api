import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Backend/backend_service.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:flutter_rest_api/models/note_create_model.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:flutter_rest_api/screens/home_page.dart';
import 'package:flutter_rest_api/widgets/custom_button.dart';
import 'package:flutter_rest_api/widgets/input_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scalify/scalify.dart';

enum NoteViewState { viewing, editing }

class NoteView extends StatefulWidget {
  final NoteModel note;
  const NoteView({Key? key, required this.note}) : super(key: key);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final TextEditingController _noteContent = TextEditingController();
  final TextEditingController _noteTitle = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  NoteViewState _noteViewState = NoteViewState.viewing;

  void initialiseFields() {
    _noteTitle.text = widget.note.noteTitle;
    _noteContent.text = widget.note.noteID;
  }

  @override
  void initState() {
    initialiseFields();
    super.initState();
  }

  String leftButtonText = "Delete";
  String rightButtonText = "Edit";
  bool isButtonActive = true;

  // void saveNote() async {
  //   setState(() {
  //     buttonText = "Saving";
  //     isButtonActive = false;
  //   });
  //   final note = NoteCreate(
  //       noteTitle: _noteTitle.text.capitalize(),
  //       noteContent: _noteContent.text.capitalize());
  //   bool isNoteCreated = await BackendService.saveNotes(note);

  //   if (isNoteCreated) {
  //     setState(() {
  //       buttonText = "Saved";
  //       isButtonActive = true;
  //     });
  //     Navigator.pushAndRemoveUntil(context,
  //         MaterialPageRoute(builder: (context) {
  //       return const HomePage();
  //     }), (route) => false);
  //   } else {
  //     setState(() {
  //       buttonText = "Something Went Wrong!";
  //       isButtonActive = true;
  //     });
  //   }
  // }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Note",
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                  if (isKeyBoard) const VerticalSpacing(of: 6),
                  const VerticalSpacing(of: 6),
                  Center(
                    child: SizedBox(
                      height: !isKeyBoard ? 12.h : 20.h,
                      width: 60.w,
                      child: SvgPicture.asset('assets/note.svg'),
                    ),
                  ),
                  if (isKeyBoard) const VerticalSpacing(of: 6),
                  const VerticalSpacing(of: 6),
                  InputContainer(
                      onlyRead: _noteViewState == NoteViewState.viewing
                          ? true
                          : false,
                      label: _noteTitle.text,
                      maxLines: 1,
                      textController: _noteTitle),
                  const VerticalSpacing(of: 2),
                  InputContainer(
                      onlyRead: _noteViewState == NoteViewState.viewing
                          ? true
                          : false,
                      label: _noteContent.text,
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            invert: true,
            width: 44.w,
            buttonLabel: leftButtonText,
            buttonAction: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      title: Text(
                        "Are you sure you want to delete this note?",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      actions: [
                        DialogButton(
                          buttonLabel: "Cancel",
                          buttonAction: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        DialogButton(
                          buttonLabel: "Delete",
                          buttonAction: () async {
                            Navigator.of(context).pop();

                            final bool result = await BackendService.deleteNote(
                                widget.note.noteID);

                            if (result) {
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) {
                              //   return const HomePage();
                              // }));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      content: Text(
                                        "Something Went Wrong",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )));
                            }
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          const HorizontalSpacing(),
          CustomButton(
            width: 44.w,
            buttonLabel: rightButtonText,
            buttonAction: () {
              if (isButtonActive) {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //saveNote();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback buttonAction;

  const DialogButton({
    Key? key,
    required this.buttonLabel,
    required this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
        onPressed: buttonAction,
        child: Text(
          buttonLabel,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ),
        ));
  }
}
