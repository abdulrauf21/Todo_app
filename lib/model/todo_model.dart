class TodoModel {
  String userId;
  String title;
  String description;
  bool isDone;
  String dateCreated;
  TodoModel({
    required this.userId,
    required this.title,
    required this.description,
    required this.isDone,
    required this.dateCreated,
  });
}
