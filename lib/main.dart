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
import 'package:tutorial/model_page.dart';

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
      home: ModelScreen(),
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
    final WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: CustomPaint(
            size: Size(
                WIDTH,
                (WIDTH * 0.5833333333333334)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
          ),
        ));
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

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1925000, size.height * 0.4171429);
    path_0.lineTo(size.width * 0.6325000, size.height * 0.4457143);
    path_0.lineTo(size.width * 0.4991667, size.height * 0.5971429);
    path_0.lineTo(size.width * 0.1925000, size.height * 0.4171429);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Layer 1

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3125000, size.height * 0.4871429);
    path_1.lineTo(size.width * 0.3108333, size.height * 0.5471429);
    path_1.lineTo(size.width * 0.4983333, size.height * 0.5985714);
    path_1.lineTo(size.width * 0.7825000, size.height * 0.2142857);
    path_1.lineTo(size.width * 0.5033333, size.height * 0.3114286);

    canvas.drawPath(path_1, paint_fill_1);

    // Layer 1

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
