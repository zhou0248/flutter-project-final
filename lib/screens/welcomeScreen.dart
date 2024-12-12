import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
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
        title: const Text("Movie Night"),
        foregroundColor: AppTheme.appBarTheme.foregroundColor,
        backgroundColor: AppTheme.appBarTheme.backgroundColor,
        titleTextStyle: AppTheme.textTheme.titleMedium,
      ),
      body: Center(
        child: Padding(
          padding: AppTheme.defaultPadding,
          child: Column(
            children: [
              Padding(
                padding: AppTheme.defaultPadding,
                child: ElevatedButton(
                  style: AppTheme.elevatedButtonStyle,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CodeSharingScreen(),
                        ));
                  },
                  child: const Text('Start Session'),
                ),
              ),
              Padding(
                padding: AppTheme.defaultPadding,
                child: ElevatedButton(
                  style: AppTheme.elevatedButtonStyle,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CodeEnteringScreen(),
                        ));
                  },
                  child: const Text('Join Session'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
