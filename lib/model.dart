class Model {
  String name;

  String dept;

  // Constructor
  Model({required this.name, required this.dept});

  // toJson method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dept': dept,
    };
  }

  // fromJson method to create an object from a Map
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      name: json['name'],
      dept: json['dept'],
    );
  }
}
