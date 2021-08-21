import 'dart:async';

import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/widgets.dart';

class FlutterFlipBuilder extends StatefulWidget {
  final OnDeviceFullyOpenedBuilder onDeviceFullyOpened;
  final OnDeviceSemiOpenedBuilder? onDeviceSemiOpened;
  final OnDeviceClosedBuilder? onDeviceClosed;

  const FlutterFlipBuilder({
    required this.onDeviceFullyOpened,
    this.onDeviceSemiOpened,
    this.onDeviceClosed,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _FlutterFlipListenerState createState() => _FlutterFlipListenerState();
}

class _FlutterFlipListenerState extends State<FlutterFlipBuilder> {
  late StreamSubscription? _eventSubscription;
  _FlipState _currentState = _FlipState.unknown;

  @override
  void initState() {
    super.initState();

    _eventSubscription = DualScreenInfo.hingeAngleEvents.listen(
      (double hingeAngle) {
        if (hingeAngle == 180.0) {
          _currentState = _FlipState.fullyOpened;
        } else if (hingeAngle == 90.0) {
          _currentState = _FlipState.semiOpened;
        } else if (hingeAngle == 0.0) {
          _currentState = _FlipState.closed;
        }

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentState) {
      case _FlipState.semiOpened:
        return widget.onDeviceSemiOpened?.call(context) ??
            widget.onDeviceFullyOpened.call(context);
      case _FlipState.closed:
        return widget.onDeviceClosed?.call(context) ??
            widget.onDeviceFullyOpened.call(context);
      case _FlipState.fullyOpened:
      case _FlipState.unknown:
      default:
        return widget.onDeviceFullyOpened.call(context);
    }
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }
}

enum _FlipState {
  unknown,
  fullyOpened,
  semiOpened,
  closed,
}

typedef OnDeviceFullyOpenedBuilder = WidgetBuilder;
typedef OnDeviceSemiOpenedBuilder = WidgetBuilder;
typedef OnDeviceClosedBuilder = WidgetBuilder;
