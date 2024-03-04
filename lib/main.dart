import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial/auth_gate.dart';
import 'package:tutorial/firebase_options.dart';
import 'package:tutorial/login)_page.dart';
import 'package:tutorial/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'd',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbConn = FirebaseFirestore.instance;
  TextEditingController ct = TextEditingController();
  TextEditingController ct2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('pstu')
                  .orderBy('name', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final resoponse = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: resoponse.length,
                  itemBuilder: (context, index) {
                    return Text(
                      '${resoponse[index]['name']} - ${resoponse[index]['dept']} - ${resoponse[index]['demo']}',
                      style: TextStyle(fontSize: 30),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: ct,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: ct2,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  viewAllData();
                },
                child: Text('Submit'))
          ],
        )));
  }
}

void addToDatabase(String name, String dept) async {
  FirebaseFirestore.instance
      .collection('pstu')
      .doc('ABCD')
      .set({'name': name, 'dept': dept, 'demo': 2});
}

void viewAllData() async {
  final respoonse = await FirebaseFirestore.instance
      .collection('pstu')
      .doc('iOWDuto7ybKcvkUzOMuL')
      .get();
  final datas = respoonse.data();
  Model temp = Model.fromJson(datas!);
  print(temp.name);

  // for (var element in datas) {
  //   print(element['name']);
  // }
}
