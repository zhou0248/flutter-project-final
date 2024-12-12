import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/codeEnteringScreen.dart';
import './screens/codeSharingScreen.dart';
import './screens/welcomeScreen.dart';
import './screens/selectionScreen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MainScreen> {
//   int _currentIndex = 0;

//   List _screens = [HomePage(), DataPage()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         destinations: [
//           NavigationDestination(icon: (Icon(Icons.home)), label: 'Home'),
//           NavigationDestination(icon: (Icon(Icons.data_usage)), label: 'Data')
//         ],
//       ),
//     );
//   }
// }
