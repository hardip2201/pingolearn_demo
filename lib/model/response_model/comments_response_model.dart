import 'dart:convert';

List<CommentResponseModel> commentResponseModelFromJson(String str) =>
    List<CommentResponseModel>.from(
        json.decode(str).map((x) => CommentResponseModel.fromJson(x)));

String commentResponseModelToJson(List<CommentResponseModel> data) =>
    json.encode(List<Map<String, dynamic>>.from(data.map((x) => x.toJson())));

class CommentResponseModel {
  CommentResponseModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  int postId;
  int id;
  String name;
  String email;
  String body;

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentResponseModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
