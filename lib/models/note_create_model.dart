class NoteCreate {
  final String noteTitle;
  final String noteContent;

  NoteCreate({required this.noteTitle, required this.noteContent});

  Map<String, dynamic> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
