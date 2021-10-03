import 'package:flutter/material.dart';
import 'package:flutter_rest_api/widgets/dialog_button.dart';

Future<DialogButtonState> createDialog(BuildContext context) async {
  DialogButtonState dialogButtonState = DialogButtonState.doNothing;

  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            DialogButton(
              buttonLabel: "Cancel",
              buttonAction: () {
                Navigator.of(context).pop(dialogButtonState);
              },
            ),
            DialogButton(
              buttonLabel: "Delete",
              buttonAction: () {
                dialogButtonState = DialogButtonState.deleteNote;
                Navigator.of(context).pop(dialogButtonState);
              },
            ),
          ],
        );
      });
}
