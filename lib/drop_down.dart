import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tutorial/model_page.dart';

class TypeAheadScreen extends StatefulWidget {
  @override
  _TypeAheadScreenState createState() => _TypeAheadScreenState();
}

class _TypeAheadScreenState extends State<TypeAheadScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = ['Apple', 'Banana', 'Orange', 'Mango'];
  List<StudentModel> students = [];
  var isLoaded;

  Future<bool> fetchAllData() async {
    students.clear();
    final rawresponse =
        await FirebaseFirestore.instance.collection('student').get();
    for (var element in rawresponse.docs) {
      StudentModel newStudent = StudentModel.fromJson(element.data());
      students.add(newStudent);
    }
    print(students[0].toJson());

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    isLoaded = fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Typeahead Example'),
      ),
      body: FutureBuilder(
          future: isLoaded,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TypeAheadField(
                    controller: _controller,
                    suggestionsCallback: (pattern) {
                      // return _suggestions
                      //     .where((item) => item
                      //         .toLowerCase()
                      //         .contains(pattern.toLowerCase()))
                      //     .toList();
                      return students
                          .where((element) => element.name
                              .toLowerCase()
                              .toString()
                              .contains(pattern.toLowerCase()))
                          .toList()
                          .map((e) => e.name)
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSelected: (suggestion) {
                      final selectedStudent = students.firstWhere(
                        (element) => element.name == suggestion,
                      );
                      //selectedStudent.name
                      //selectedStudent.id
                      //selectedStudent.faculty

                      setState(() {
                        _controller.text = suggestion;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Selected Value: ${_controller.text}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
