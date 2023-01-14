class NoteModel {
  int? id;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;

   NoteModel({this.text, this.createdAt, this.updatedAt, this.id});


  NoteModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
