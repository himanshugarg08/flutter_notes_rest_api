import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/screens/add_note.dart';
import 'package:scalify/scalify.dart';

import '../widgets/notes_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    /*required this.customTheme*/
  }) : super(key: key);

  //final CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    Scalify.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacing(of: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notes", style: Theme.of(context).textTheme.headline3),
                ],
              ),
              const VerticalSpacing(of: 2),
              const Expanded(child: NotesList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showDialog(
          //     context: context, builder: (context) => addDialogCall(context));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
