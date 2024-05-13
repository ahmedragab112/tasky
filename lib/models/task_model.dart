class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;
  TaskModel(
      {required this.userId,
      required this.date,
      required this.description,
      this.id = '',
      this.isDone = false,
      required this.title});

  TaskModel.fromjson(Map<String, dynamic> json)
      : this(
            date: json['date'],
            description: json['description'],
            id: json['id'],
            isDone: json['isDone'],
            title: json['title'],
            userId: json['userId']);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'isDone': isDone,
      'title': title,
      'userId': userId
    };
  }
}
