class NoteModel {
  final String noteID;
  final String noteTitle;
  final String createDateTime;
  final String latestEditDateTime;

  NoteModel(
      {required this.noteID,
      required this.noteTitle,
      required this.createDateTime,
      required this.latestEditDateTime});

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
        noteID: map['noteID'],
        noteTitle: map['noteTitle'],
        createDateTime: map['createDateTime'],
        latestEditDateTime: map['latestEditDateTime'] ?? "NULL");
  }
}

class NoteModelExtended {
  final String noteID;
  final String noteTitle;
  final String noteContent;
  final String createDateTime;
  final String latestEditDateTime;

  NoteModelExtended(
      {required this.noteID,
      required this.noteTitle,
      required this.noteContent,
      required this.createDateTime,
      required this.latestEditDateTime});

  factory NoteModelExtended.fromJson(Map<String, dynamic> map) {
    return NoteModelExtended(
        noteID: map['noteID'],
        noteTitle: map['noteTitle'],
        noteContent: map['noteContent'],
        createDateTime: map['createDateTime'],
        latestEditDateTime: map['latestEditDateTime'] ?? "NULL");
  }
}

class NotesListFromAPI {
  static List<NoteModel> notesList = [];
}

class NoteInfo {
  static late NoteModelExtended note;
}
