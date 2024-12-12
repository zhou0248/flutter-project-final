import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/codeEnteringScreen.dart';
import './screens/codeSharingScreen.dart';
import './screens/welcomeScreen.dart';
import './screens/selectionScreen.dart';
import './helpers/appTheme.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Night',
      theme: ThemeData(
        appBarTheme: AppTheme.appBarTheme,
        colorScheme: AppTheme.colorScheme,
        textTheme: AppTheme.textTheme,
      ),
      home: const WelcomeScreen(),
    );
  }
}
