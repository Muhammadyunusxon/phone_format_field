import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_libphonenumber_windows/flutter_libphonenumber_windows.dart';
import 'package:flutter_libphonenumber_windows/flutter_libphonenumber_windows_platform_interface.dart';
import 'package:flutter_libphonenumber_windows/flutter_libphonenumber_windows_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLibphonenumberWindowsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLibphonenumberWindowsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLibphonenumberWindowsPlatform initialPlatform = FlutterLibphonenumberWindowsPlatform.instance;

  test('$MethodChannelFlutterLibphonenumberWindows is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLibphonenumberWindows>());
  });

  test('getPlatformVersion', () async {
    FlutterLibphonenumberWindows flutterLibphonenumberWindowsPlugin = FlutterLibphonenumberWindows();
    MockFlutterLibphonenumberWindowsPlatform fakePlatform = MockFlutterLibphonenumberWindowsPlatform();
    FlutterLibphonenumberWindowsPlatform.instance = fakePlatform;

    expect(await flutterLibphonenumberWindowsPlugin.getPlatformVersion(), '42');
  });
}
