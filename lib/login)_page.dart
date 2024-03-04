import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController mail = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mail,
            ),
            TextField(
              controller: pass,
            ),
            ElevatedButton(
                onPressed: () {
                  createAccount(mail.text, pass.text);
                },
                child: Text('Sign up')),
            ElevatedButton(
                onPressed: () {
                  loginUser(mail.text, pass.text);
                },
                child: Text('Login'))
          ],
        ),
      ),
    );
  }
}

void createAccount(String email, String pass) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
  } catch (e) {
    print(e.toString());
  }
}

void loginUser(String email, String pass) async {
  try {
    final response = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
  } catch (e) {
    print('eerrrroor');
    print(e.toString());
  }
}
