import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Backend/backend_service.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:flutter_rest_api/widgets/notes_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  double getNoteContainerHeight(int length) {
    double height = 3.0;
    if (length < 53) {
      height = 2.6;
    } else if (length < 40) {
      height = 2.2;
    } else if (length < 27) {
      height = 1.8;
    } else if (length < 14) {
      height = 1.4;
    }
    return height;
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
        : noteListState.isEmpty
            ? Column(
                children: [
                  const VerticalSpacing(of: 20),
                  Center(
                    child: SizedBox(
                        height: 22.h,
                        child: SvgPicture.asset('assets/empty_list.svg')),
                  ),
                  const VerticalSpacing(of: 4),
                  Text(
                    "Create your first note.",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 20),
                  )
                ],
              )
            : StaggeredGridView.countBuilder(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 4,
                staggeredTileBuilder: (index) => StaggeredTile.count(
                  2,
                  noteListState[index].noteTitle.length < 53
                      ? (noteListState[index].noteTitle.length < 40
                          ? (noteListState[index].noteTitle.length < 27
                              ? (noteListState[index].noteTitle.length < 14
                                  ? 1.4
                                  : 2.0)
                              : 2.2)
                          : 2.4)
                      : 3.0,
                ),
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
