// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  final String username;
  final String comment;
  final int rating;
  CommentModel({
    required this.username,
    required this.comment,
    required this.rating,
  });

  static List<CommentModel> getListComment() {
    List<CommentModel> listComment = [];
    listComment.add(CommentModel(
        username: "Ẩn danh", comment: "Ngon nhưng mà ít", rating: 3));

    listComment.add(CommentModel(
        username: "Ẩn danh", comment: "Ngon nhưng mà ít vãi", rating: 4));

    listComment.add(CommentModel(
        username: "Ẩn danh",
        comment: "10 điểm nhưng cho 4 sao thôi",
        rating: 4));
    listComment.add(CommentModel(
        username: "Ẩn danh", comment: "Ngon nhưng mà ít vãi", rating: 4));

    listComment.add(CommentModel(
        username: "Ẩn danh",
        comment: "10 điểm nhưng cho 4 sao thôi",
        rating: 3));
    return listComment;
  }
}
