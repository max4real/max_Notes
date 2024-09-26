class TextBodyModel {
  String text;
  TextBodyModel({required this.text});
  factory TextBodyModel.fromJson({required Map<String, dynamic> data}) {
    return TextBodyModel(text: data["insert"].toString());
  }
}
