import 'package:flutter/material.dart';

enum DialogButtonState { doNothing, deleteNote }

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
