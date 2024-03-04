import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HomePage'),
            Text(FirebaseAuth.instance.currentUser!.email.toString()),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
