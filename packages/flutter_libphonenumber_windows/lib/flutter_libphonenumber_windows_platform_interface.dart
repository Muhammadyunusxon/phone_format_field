import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_libphonenumber_windows_method_channel.dart';

abstract class FlutterLibphonenumberWindowsPlatform extends PlatformInterface {
  /// Constructs a FlutterLibphonenumberWindowsPlatform.
  FlutterLibphonenumberWindowsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLibphonenumberWindowsPlatform _instance = MethodChannelFlutterLibphonenumberWindows();

  /// The default instance of [FlutterLibphonenumberWindowsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLibphonenumberWindows].
  static FlutterLibphonenumberWindowsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLibphonenumberWindowsPlatform] when
  /// they register themselves.
  static set instance(FlutterLibphonenumberWindowsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
