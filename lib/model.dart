class StudentModel {
  String name;

  String dept;

  // Constructor
  StudentModel({required this.name, required this.dept});

  // toJson method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dept': dept,
    };
  }

  // fromJson method to create an object from a Map
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      dept: json['dept'],
    );
  }
}
