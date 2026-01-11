import 'package:flutter/material.dart';
import '../utils/session.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final userC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: userC,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (userC.text == 'admin' && passC.text == 'admin') {
                  await Session.setLogin(true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Username atau Password salah'),
                    ),
                  );
                }
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
