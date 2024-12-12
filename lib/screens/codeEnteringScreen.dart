import 'package:flutter/material.dart';

class CodeEnteringScreen extends StatefulWidget {
  const CodeEnteringScreen({super.key});

  @override
  State<CodeEnteringScreen> createState() => _CodeEnteringScreenState();
}

class _CodeEnteringScreenState extends State<CodeEnteringScreen> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a Session"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Code',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Join Session'),
            ),
          ],
        ),
      ),
    );
  }
}
