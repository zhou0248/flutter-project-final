import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:flutter_project/screens/selectionScreen.dart';
import 'package:flutter_project/helpers/httpSessionHelper.dart';

class CodeSharingScreen extends StatefulWidget {
  const CodeSharingScreen({super.key});

  @override
  State<CodeSharingScreen> createState() => _CodeSharingScreenState();
}

class _CodeSharingScreenState extends State<CodeSharingScreen> {
  int? code;

  @override
  void initState() {
    super.initState();
    _getCode();
  }

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
        child: code != null
            ? Column(
                children: [
                  Padding(
                    padding: AppTheme.largePadding,
                    child: Text('Code: $code',
                        style: AppTheme.textTheme.titleMedium),
                  ),
                  ElevatedButton(
                    style: AppTheme.elevatedButtonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MovieSelectionScreen(),
                          ));
                    },
                    child: const Text('Start Session'),
                  ),
                ],
              )
            : Column(
                children: [
                  const Padding(
                    padding: AppTheme.largePadding,
                    child: CircularProgressIndicator(),
                  ),
                  Text('Getting code...', style: AppTheme.textTheme.bodyMedium),
                ],
              ),
      ),
    );
  }

  Future<void> _getCode() async {
    final httpSession = HttpSessionHelper();
    final sessionCode = await httpSession.getCode();
    setState(() {
      code = sessionCode;
    });
  }
}
