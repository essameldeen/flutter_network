class Todo {
  int id = 0;
  int userId = 0;
  String title = "";
  bool completed = false;

  Todo(
      {required this.userId, required this.id, required this.title, required this.completed});

  factory Todo.fromJson(Map<String, dynamic> jsonObject){
    return Todo(userId: jsonObject['userId'],id: jsonObject['id'],title: jsonObject['title']
        ,completed: jsonObject['completed']);
  }
}
