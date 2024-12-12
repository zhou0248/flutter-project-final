import 'package:flutter/material.dart';

class CodeSharingScreen extends StatefulWidget {
  const CodeSharingScreen({super.key});

  @override
  State<CodeSharingScreen> createState() => _CodeSharingScreenState();
}

class _CodeSharingScreenState extends State<CodeSharingScreen> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Code"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Code: $code'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Share Code'),
            ),
          ],
        ),
      ),
    );
  }
}
