import 'package:flutter/material.dart';
import 'package:flutter_flip_devices/flutter_flip_devices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flip Devices for Flutter'),
        ),
        body: Column(
          children: const [
            Expanded(
              child: FlipListenerDemo(),
            ),
            Expanded(
              child: Center(
                child: FlipBuilderDemo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class FlipListenerDemo extends StatelessWidget {
  const FlipListenerDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterFlipListener(
      onDeviceClosed: () {
        showSnackBar(context, 'Closed');
      },
      onDeviceSemiOpened: () {
        showSnackBar(context, 'Semi-opened');
      },
      onDeviceFullyOpened: () {
        showSnackBar(context, 'Fully opened');
      },
      child: Center(
        child: Text('Hello world !'),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class FlipBuilderDemo extends StatelessWidget {
  const FlipBuilderDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterFlipBuilder(
      onDeviceClosed: (BuildContext context) {
        return Text('Closed');
      },
      onDeviceSemiOpened: (BuildContext context) {
        return Text('Semi-opened');
      },
      onDeviceFullyOpened: (BuildContext context) {
        return Text('Fully opened');
      },
    );
  }
}
