import 'package:flutter/material.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:flutter_rest_api/screens/note_view.dart';
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
    final dateTimeInIST =
        DateTime.parse(dateTime).add(const Duration(hours: 5, minutes: 30));

    final date =
        "${dateTimeInIST.day.toString()} ${monthsInYear[dateTimeInIST.month]}";
    final hour = dateTimeInIST.hour > 12
        ? "${dateTimeInIST.hour % 12}"
        : "${dateTimeInIST.hour}";
    final minute = dateTimeInIST.minute < 10
        ? "0${dateTimeInIST.minute}"
        : "${dateTimeInIST.minute}";

    return "$date, $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NoteView(note: note);
        }));
      },
      child: Container(
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Text(
                    note.latestEditDateTime == "NULL"
                        ? date(note.createDateTime)
                        : date(note.latestEditDateTime),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
