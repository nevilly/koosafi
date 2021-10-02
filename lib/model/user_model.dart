class Users {
  int id;
  final String username;
  final String title;
  final String password;

  Users(
      {required this.id,
      required this.username,
      required this.password,
      required this.title});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: int.parse(json['id']),
        username: json['username'] as String,
        title: json['title'] as String,
        password: json['password']);
  }
}
