import 'dart:convert';
import 'package:get/get.dart';

import 'package:note_app/constants/api_urls.dart';
import 'package:note_app/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteController extends GetxController {
  final noteList = <NoteModel>[].obs;
  final noteListFiltered = <NoteModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  int uuid() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch;
  }

  void getData() async {
    noteList.value = [];
    noteListFiltered.value = [];
  }

  Future postData({required String body}) async {
    NoteModel note = NoteModel(
        id: uuid(),
        text: body,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    noteList.add(note);
    noteListFiltered.value = noteList;
  }

  Future updateData({required String text, NoteModel? note}) async {
    //getting index of item
    int index = noteList.indexOf(note);
    // updating values
    note?.text = text;
    note?.updatedAt = DateTime.now();

    // replacing item with updated data
    noteList[index] = note!;
    noteListFiltered.value = noteList;
  }

  Future deleteData({required int? id}) async {
    noteList.removeWhere((item) => item.id == id);
    noteListFiltered.value = noteList;
  }

  Future filterData({required String query}) async {
    if (query.isNotEmpty) {
      noteListFiltered.value = noteList
          .where(
              (item) => item.text!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      noteListFiltered.value = noteList;
    }
  }

// =================================================================================================
// CRUD backend API===============================================================================
//   ===============================================================================================

// create-----------------------
  Future createNoteFromApi({required String text}) async {
    // id should be generated in backend
    var requestBody = {
      "text": text,
      "created_at": DateTime.now(),
      "updated_at": DateTime.now(),
    };

    final response =
        await http.post(body: requestBody, Uri.parse(ApiUrls.TODO_CREATE_API));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create Note list');
    }
  }

  //read------------------------
  Future fetchNotesFromApi() async {
    final response = await http.get(Uri.parse(ApiUrls.TODOS_API));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      for (var d in jsonData) {
        noteList.add(NoteModel.fromJson(d));
        noteListFiltered.add(NoteModel.fromJson(d));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Note list');
    }
  }

  Future fetchSingleNoteFromApi({required int id}) async {
    final response = await http.get(Uri.parse(ApiUrls.TODO_API(id)));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      NoteModel note = NoteModel.fromJson(jsonData);
      //then update in new variable for details page
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Note');
    }
  }

  Future updateNoteFromApi({required String text, required int id}) async {
    var requestBody = {
      "text": text,
      "updated_at": DateTime.now(),
    };

    final response =
        await http.patch(body: requestBody, Uri.parse(ApiUrls.TODO_API(id)));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update Note');
    }
  }

// delete --------------------------------
  Future deleteNoteFromApi({required int id}) async {
    final response = await http.delete(Uri.parse(ApiUrls.TODO_API(id)));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to delete Note');
    }
  }
}
