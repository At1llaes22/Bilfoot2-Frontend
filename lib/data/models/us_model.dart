class UserModel {
  UserModel({
    required this.name,
    required this.age,
    this.car,
  });
  late final String name;
  late final int age;
  late final Null car;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    car = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['age'] = age;
    _data['car'] = car;
    return _data;
  }
}
