class TodoModel {
  final int id;
  final String title;
  final String date;
  final String category;
  final String isUpdate;

  TodoModel({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.isUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'category': category,
      'isUpdated': isUpdate,
    };
  }

  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        date = res["date"],
        category = res["category"],
        isUpdate = res["isUpdated"];
}
