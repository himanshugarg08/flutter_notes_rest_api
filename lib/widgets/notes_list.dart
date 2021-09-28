import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Backend/backend_service.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:flutter_rest_api/widgets/notes_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scalify/scalify.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  bool isLoading = true;
  List<NoteModel> noteListState = NotesListFromAPI.notesList;

  void getNotesFromAPI() async {
    bool response = await BackendService.getNotes();
    if (response) {
      isLoading = !isLoading;
      noteListState = NotesListFromAPI.notesList;
      setState(() {});
    }
  }

  @override
  void initState() {
    getNotesFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ))
        : StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 4,
            staggeredTileBuilder: (index) => StaggeredTile.count(
                2,
                noteListState[index].noteTitle.length < 40
                    ? noteListState[index].noteTitle.length < 14
                        ? 1.4
                        : 1.6
                    : 2.2),
            itemCount: noteListState.length,
            itemBuilder: (context, index) => NoteContainer(
              index: index,
              note: noteListState[index],
            ),
            crossAxisSpacing: 2.h,
            mainAxisSpacing: 2.h,
          );
  }
}
