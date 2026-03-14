import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_libphonenumber_windows_platform_interface.dart';

/// An implementation of [FlutterLibphonenumberWindowsPlatform] that uses method channels.
class MethodChannelFlutterLibphonenumberWindows extends FlutterLibphonenumberWindowsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_libphonenumber_windows');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
