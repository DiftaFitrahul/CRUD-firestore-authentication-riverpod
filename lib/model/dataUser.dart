class DataUser {
  final String name;
  final int age;
  final DateTime date;

  DataUser({required this.name, required this.age, required this.date});

  factory DataUser.fromFirestore(Map<String, dynamic> json) {
    return DataUser(
        name: json["name"], age: json["age"], date: json["date"].toDate());
  }
}
