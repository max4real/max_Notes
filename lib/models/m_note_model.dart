class NoteModel {
  String id;
  DateTime createDate;
  String noteBody;
  NoteModel(
      {required this.id, required this.createDate, required this.noteBody});

  factory NoteModel.fromApi({required Map<String, dynamic> data}) {
    return NoteModel(
      id: data["id"].toString(),
      createDate:
          DateTime.tryParse(data["createdAt"].toString()) ?? DateTime.now(),
      noteBody: data["body"].toString(),
    );
  }
}
// {
//       "id": "0445e11b-2e34-4033-a16c-ac3f731a2eae",
//       "text": "[{\"insert\":\"HELLO\\n\"}]",
//       "createdAt": "2024-09-26T07:35:13.224Z",
//       "isDeleted": false
//     },