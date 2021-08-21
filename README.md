# Helper for "Flip" devices

[![Pub](https://img.shields.io/pub/v/flutter_flip_devices.svg)](https://pub.dartlang.org/packages/flutter_flip_devices)

A plugin to easily develop Flutter applications for Flip devices like Samsung Galaxy Z Flip or Samsung Galaxy Z Flip 3.
It will notify when the device is either fully-opened, semi-opened and closed. On non-"flip" devices, it will always considered the screen as fully-opened.

## FlutterFlipListener

A Flutter Widget to be notified when the hinge state changed.

```dart
FlutterFlipListener(
  onDeviceClosed: () {},
  onDeviceSemiOpened: () {},
  onDeviceFullyOpened: () {},
  child: YourWidget(),
);
```

## FlutterFlipBuilder

A Flutter Widget to provide a Widget dependeing on the hinge state.

```dart
FlutterFlipBuilder(
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
```