import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:flutter_project/screens/selectionScreen.dart';

class CodeEnteringScreen extends StatefulWidget {
  const CodeEnteringScreen({super.key});

  @override
  State<CodeEnteringScreen> createState() => _CodeEnteringScreenState();
}

class _CodeEnteringScreenState extends State<CodeEnteringScreen> {
  final _formKey = GlobalKey<FormState>();
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
                          code = value;
                        });
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 4) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieSelectionScreen(),
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
}
