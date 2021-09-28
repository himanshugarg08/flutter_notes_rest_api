import 'package:flutter/material.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:scalify/scalify.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    Key? key,
    required this.index,
    required this.note,
  }) : super(key: key);

  final int index;
  final NoteModel note;

  String date(String dateTime) {
    final date =
        "${DateTime.parse(dateTime).day.toString()} ${monthsInYear[DateTime.parse(dateTime).month]}";
    final hour = "${DateTime.parse(dateTime).hour}";
    final minute = DateTime.parse(dateTime).minute < 10
        ? "0${DateTime.parse(dateTime).minute}"
        : "${DateTime.parse(dateTime).minute}";

    return "$date, $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorsList[index % colorsList.length],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                note.noteTitle,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.fade,
              ),
            ),
            const VerticalSpacing(of: 1),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: kDarkColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Text(
                  date(note.createDateTime),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
