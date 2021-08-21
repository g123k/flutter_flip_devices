import 'dart:async';

import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/widgets.dart';

class FlutterFlipListener extends StatefulWidget {
  final Widget child;
  final OnDeviceFullyOpenedListener? onDeviceFullyOpened;
  final OnDeviceSemiOpenedListener? onDeviceSemiOpened;
  final OnDeviceClosedListener? onDeviceClosed;

  const FlutterFlipListener({
    required this.child,
    this.onDeviceFullyOpened,
    this.onDeviceSemiOpened,
    this.onDeviceClosed,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _FlutterFlipListenerState createState() => _FlutterFlipListenerState();
}

class _FlutterFlipListenerState extends State<FlutterFlipListener> {
  StreamSubscription? _eventSubscription;

  @override
  void initState() {
    super.initState();

    DualScreenInfo.hasHingeAngleSensor.then(
      (bool hasHinge) {
        if (hasHinge) {
          _listenToHingeEvents();
        } else {
          widget.onDeviceFullyOpened?.call();
        }
      },
    );
  }

  void _listenToHingeEvents() {
    try {
      _eventSubscription = DualScreenInfo.hingeAngleEvents.listen(
        (double hingeAngle) {
          if (hingeAngle == 180.0) {
            widget.onDeviceFullyOpened?.call();
          } else if (hingeAngle == 90.0) {
            widget.onDeviceSemiOpened?.call();
          } else if (hingeAngle == 0.0) {
            widget.onDeviceClosed?.call();
          }
        },
        onError: (_, __) {
          widget.onDeviceFullyOpened?.call();
        },
      );
    } catch (error) {
      widget.onDeviceFullyOpened?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }
}

typedef OnDeviceFullyOpenedListener = Function();
typedef OnDeviceSemiOpenedListener = Function();
typedef OnDeviceClosedListener = Function();
