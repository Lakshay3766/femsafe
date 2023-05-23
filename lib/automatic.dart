import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'voice.dart'; // Import the voice.dart file

class AutomaticPage extends StatefulWidget {
  @override
  _AutomaticPageState createState() => _AutomaticPageState();
}

class _AutomaticPageState extends State<AutomaticPage> {
  bool isVoiceActivationEnabled = false;
  bool isShakeDetectionEnabled = false;
  bool isGPSTechnologyEnabled = false;
  bool isPermissionGranted = false;

  ShakeDetector? _shakeDetector;
  Position? _currentPosition;
  bool isTriggered = false;

  @override
  void initState() {
    super.initState();

    // Initialize shake detector
    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: () {
        if (isShakeDetectionEnabled && isVoiceActivationEnabled) {
          setState(() {
            isTriggered = true;
          });
          Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              isTriggered = false;
            });
          });
        }
      },
    );

    // Initialize geolocator
    _determinePosition();

    // Request necessary permissions
    _requestPermissions();
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permission has not been granted
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permission has been denied
        return;
      }
    }

    // Get the current position
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> _requestPermissions() async {
    final permissions = [
      Permission.sms,
      Permission.location,
      Permission.microphone,
    ];

    final status = await permissions.request();

    // Check if all permissions are granted
    setState(() {
      isPermissionGranted = status[Permission.sms]!.isGranted &&
          status[Permission.location]!.isGranted &&
          status[Permission.microphone]!.isGranted;
    });
  }

  void _showDangerScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Danger Detected'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text('You are in danger! Help is on the way.'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Perform actions on danger screen button press
                // For example, make an emergency call, send an SOS message, etc.
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Method to enable voice activation
  Future<void> _enableVoiceActivation() async {
    final permissionStatus = await Permission.microphone.request();

    if (permissionStatus.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VoicePage()),
      );
    } else {
      debugPrint('Microphone permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Automatic Features'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Voice Activation'),
            subtitle: Text('Activate features using voice commands'),
            trailing: Switch(
              value: isVoiceActivationEnabled,
              onChanged: (value) async {
                if (value) {
                  await _enableVoiceActivation();
                }
                setState(() {
                  isVoiceActivationEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Shake Detection'),
            subtitle: Text('Perform action on phone shake'),
            trailing: Switch(
              value: isShakeDetectionEnabled,
              onChanged: (value) {
                setState(() {
                  isShakeDetectionEnabled = value;
                });

                if (isShakeDetectionEnabled) {
                  _shakeDetector?.startListening();
                } else {
                  _shakeDetector?.stopListening();
                }
              },
            ),
          ),
          ListTile(
            title: Text('GPS Technology'),
            subtitle: Text('Utilize GPS for location-based features'),
            trailing: Switch(
              value: isGPSTechnologyEnabled,
              onChanged: (value) {
                setState(() {
                  isGPSTechnologyEnabled = value;
                });

                if (isGPSTechnologyEnabled) {
                  _determinePosition();
                }
              },
            ),
          ),
          if (isTriggered)
            ListTile(
              title: Text('Danger Detected'),
              subtitle: Text('You are in danger! Sending help...'),
              trailing: Icon(Icons.warning),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isTriggered ? _showDangerScreen : null,
        child: Icon(Icons.warning),
      ),
    );
  }
}
