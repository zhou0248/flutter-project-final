import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './codeSharingScreen.dart';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String deviceUUID = '';

  @override
  void initState() {
    super.initState();
    _fetchUUID();
  }

  Future<void> _fetchUUID() async {
    String deviceUUID = '';

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
    }
    if (mounted) {
      setState(() {
        deviceUUID = deviceUUID;
      });
    }
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CodeSharingScreen(),
                    ));
              },
              child: const Text('Start Session'),
            ),
            Text('Device UUID: $deviceUUID'),
          ],
        ),
      ),
    );
  }
}
