import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './codeSharingScreen.dart';
import './codeEnteringScreen.dart';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUUID();
  }

  Future<void> _fetchUUID() async {
    String deviceUUID;
    final prefs = await SharedPreferences.getInstance();

    try {
      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        deviceUUID = await androidIdPlugin.getId() ?? "Unknown Android Device";
      } else if (Platform.isIOS) {
        final deviceInfoPlugin = DeviceInfoPlugin();
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceUUID = iosInfo.identifierForVendor ?? "Unknown iOS Device";
      } else {
        deviceUUID = "Unknown Device";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      deviceUUID = "Error: $e";
    }

    if (kDebugMode) {
      print("Device UUID: $deviceUUID");
    }

    await prefs.setString('deviceUUID', deviceUUID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Night"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CodeSharingScreen(),
                      ));
                },
                child: const Text('Start a Session'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CodeEnteringScreen(),
                      ));
                },
                child: const Text('Join a Session'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
