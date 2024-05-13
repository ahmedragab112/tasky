class UserModel {
  final String name;
  final String age;
  final String id;
  final String email;
  UserModel({
    required this.email,
    required this.age,
    required this.id,
    required this.name,
  });
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            email: json['email'],
            age: json['age'],
            name: json['name'],
            id: json['id']);
  Map<String, dynamic> toJson() =>
      {'name': name, 'age': age, 'id': id, 'email': email};
}
