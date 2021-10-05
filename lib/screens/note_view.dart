import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Backend/backend_service.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:flutter_rest_api/models/note_create_model.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:flutter_rest_api/screens/home_page.dart';
import 'package:flutter_rest_api/widgets/custom_button.dart';
import 'package:flutter_rest_api/widgets/custom_dialog.dart';
import 'package:flutter_rest_api/widgets/dialog_button.dart';
import 'package:flutter_rest_api/widgets/input_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scalify/scalify.dart';
import 'package:shimmer/shimmer.dart';

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

  NoteViewState noteViewState = NoteViewState.viewing;

  bool isLoading = false;
  bool isDataFetching = true;

  void initialiseFields() async {
    final result = await BackendService.getNotesByID(widget.note.noteID);
    if (result) {
      _noteTitle.text = NoteInfo.note.noteTitle;
      _noteContent.text = NoteInfo.note.noteContent;
      isDataFetching = !isDataFetching;
      setState(() {});
    }
  }

  @override
  void initState() {
    initialiseFields();
    super.initState();
  }

  bool isButtonActive = true;
  String buttonText = "Save";

  void editNote() async {
    setState(() {
      buttonText = "Saving";
      isButtonActive = false;
    });
    final note = NoteCreate(
        noteTitle: _noteTitle.text.capitalize(),
        noteContent: _noteContent.text.capitalize());
    bool isNoteCreated =
        await BackendService.editNote(NoteInfo.note.noteID, note);

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
        buttonText = "Try Again";
        isButtonActive = true;
      });
    }
  }

  void onDelete() async {
    final result = await createDialog(context);

    if (result == DialogButtonState.deleteNote) {
      setState(() {
        isLoading = !isLoading;
      });
      final bool result = await BackendService.deleteNote(widget.note.noteID);
      if (result) {
        setState(() {
          isLoading = !isLoading;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Text(
              "Something Went Wrong",
              style: Theme.of(context).textTheme.subtitle1,
            )));
        setState(() {
          isLoading = !isLoading;
        });
      }
    } else if (result == DialogButtonState.doNothing) {}
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  isDataFetching
                      ? Shimmer.fromColors(
                          child: const AddNoteShimmer(),
                          baseColor: Theme.of(context).colorScheme.surface,
                          highlightColor:
                              Theme.of(context).colorScheme.onSurface,
                        )
                      : Column(
                          children: [
                            InputContainer(
                                onlyRead: noteViewState == NoteViewState.viewing
                                    ? true
                                    : false,
                                label: "Title",
                                maxLines: 1,
                                textController: _noteTitle),
                            const VerticalSpacing(of: 2),
                            InputContainer(
                                onlyRead: noteViewState == NoteViewState.viewing
                                    ? true
                                    : false,
                                label: "Content",
                                maxLines: 4,
                                textController: _noteContent),
                          ],
                        ),
                  const VerticalSpacing(of: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                const VerticalSpacing(of: 4),
              ],
            )
          : noteViewState == NoteViewState.viewing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      invert: true,
                      width: 44.w,
                      buttonLabel: "Delete",
                      buttonAction: onDelete,
                    ),
                    const HorizontalSpacing(),
                    CustomButton(
                      width: 44.w,
                      buttonLabel: "Edit",
                      buttonAction: () {
                        setState(() {
                          noteViewState = NoteViewState.editing;
                        });
                      },
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      invert: true,
                      width: 44.w,
                      buttonLabel: "Cancel",
                      buttonAction: () {
                        setState(() {
                          noteViewState = NoteViewState.viewing;
                          _noteTitle.text = NoteInfo.note.noteTitle;
                          _noteContent.text = NoteInfo.note.noteContent;
                        });
                      },
                    ),
                    const HorizontalSpacing(),
                    CustomButton(
                      width: 44.w,
                      buttonLabel: buttonText,
                      buttonAction: () {
                        FocusScope.of(context).unfocus();
                        if (isButtonActive) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (NoteInfo.note.noteTitle == _noteTitle.text &&
                                NoteInfo.note.noteContent ==
                                    _noteContent.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      content: Text(
                                        "Please make some changes to save.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )));
                            } else {
                              editNote();
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
    );
  }
}

class AddNoteShimmer extends StatelessWidget {
  const AddNoteShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.6.h),
            child: TextFormField(
              maxLines: 1,
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const VerticalSpacing(of: 2),
        Center(
          child: Container(
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.6.h),
            child: TextFormField(
              maxLines: 4,
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
