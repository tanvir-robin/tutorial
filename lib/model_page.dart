import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelScreen extends StatefulWidget {
  const ModelScreen({super.key});

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  Future sendData(Map<String, dynamic> sendingData) async {
    await FirebaseFirestore.instance.collection('student').add(sendingData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('student').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final studentData = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: studentData.length,
                  itemBuilder: (context, index) {
                    StudentModel fetchedStudent =
                        StudentModel.fromJson(studentData[index].data());

                    return Text(
                        '${fetchedStudent.name} - ${fetchedStudent.id} - ${fetchedStudent.faculty}');
                  },
                );
              }),
          ElevatedButton(
              onPressed: () {
                StudentModel newSt = StudentModel('AAA', '19', '222');
                sendData(newSt.toJson());
              },
              child: Text('Send data'))
        ],
      ),
    ));
  }
}

class StudentModel {
  String name;
  String id;
  String faculty;

  StudentModel(this.name, this.id, this.faculty);

  factory StudentModel.fromJson(Map<String, dynamic> jsonData) {
    return StudentModel(jsonData['name'], jsonData['id'], jsonData['faculty']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'faculty': faculty};
  }
}
