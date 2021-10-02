import 'dart:convert';
import 'package:flutter_rest_api/models/note_create_model.dart';
import 'package:flutter_rest_api/models/note_model.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static const apiURL = "https://tq-notes-api-jkrgrdggbq-el.a.run.app";
  static const apiKey = "06ef2b43-061a-4581-8abd-777abed7afff";
  static const headers = {"apiKey": apiKey, "Content-Type": "application/json"};

  static Future<bool> getNotes() async {
    final response =
        await http.get(Uri.parse(apiURL + "/notes"), headers: headers);

    if (response.statusCode == 200) {
      NotesListFromAPI.notesList = List.from(jsonDecode(response.body))
          .map<NoteModel>((e) => NoteModel.fromJson(e))
          .toList();
      return true;
    }

    return false;
  }

  static Future<bool> getNotesByID(String noteID) async {
    final response = await http.get(Uri.parse(apiURL + "/notes/" + noteID),
        headers: headers);

    if (response.statusCode == 200) {
      NoteInfo.note = NoteModelExtended.fromJson(jsonDecode(response.body));

      return true;
    }

    return false;
  }

  static Future<bool> saveNotes(NoteCreate noteToCreate) async {
    final response = await http.post(Uri.parse(apiURL + "/notes"),
        headers: headers, body: json.encode(noteToCreate.toJson()));

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  static Future<bool> deleteNote(String noteID) async {
    final response = await http.delete(Uri.parse(apiURL + "/notes/" + noteID),
        headers: headers);

    if (response.statusCode == 204) {
      return true;
    }

    return false;
  }
}
