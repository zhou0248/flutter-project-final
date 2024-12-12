import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:flutter_project/screens/selectionScreen.dart';

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
            Padding(
              padding: AppTheme.largePadding,
              child: Text('Code: $code', style: AppTheme.textTheme.titleMedium),
            ),
            ElevatedButton(
              style: AppTheme.elevatedButtonStyle,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieSelectionScreen(),
                    ));
              },
              child: const Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}
