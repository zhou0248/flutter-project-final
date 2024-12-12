import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';

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
        title: const Text("Movie Night"),
        foregroundColor: AppTheme.appBarTheme.foregroundColor,
        backgroundColor: AppTheme.appBarTheme.backgroundColor,
        titleTextStyle: AppTheme.textTheme.titleMedium,
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
