import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:flutter_project/screens/selectionScreen.dart';
import 'package:flutter_project/helpers/httpSessionHelper.dart';

class CodeEnteringScreen extends StatefulWidget {
  const CodeEnteringScreen({super.key});

  @override
  State<CodeEnteringScreen> createState() => _CodeEnteringScreenState();
}

class _CodeEnteringScreenState extends State<CodeEnteringScreen> {
  final _formKey = GlobalKey<FormState>();
  int code = 0;

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
        child: SafeArea(
          child: Padding(
            padding: AppTheme.largePadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Enter Your Session Code',
                    style: AppTheme.textTheme.titleMedium,
                  ),
                  Padding(
                    padding: AppTheme.largePadding,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      style: AppTheme.textTheme.titleMedium,
                      onChanged: (value) {
                        setState(() {
                          code = int.parse(value);
                        });
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length > 4) {
                          return 'Please enter a valid code';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Code Here',
                        labelStyle: TextStyle(
                            color: AppTheme.colorScheme.onPrimary,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: AppTheme.elevatedButtonStyle,
                    onPressed: () {
                      _enterCode(code);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MovieSelectionScreen(),
                          ));
                    },
                    child: const Text('Join Session'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enterCode(int code) async {
    final httpSession = HttpSessionHelper();
    try {
      await httpSession.enterCode(code);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      }
    }
  }
}
