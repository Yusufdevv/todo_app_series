class Todo {
  final String id;
  final String title;
  final String userid;
   bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.userid,
     this.isDone = false,
  });
}
