#ifndef FLUTTER_PLUGIN_FLUTTER_LIBPHONENUMBER_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_LIBPHONENUMBER_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_libphonenumber_windows {

class FlutterLibphonenumberWindowsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterLibphonenumberWindowsPlugin();

  virtual ~FlutterLibphonenumberWindowsPlugin();

  // Disallow copy and assign.
  FlutterLibphonenumberWindowsPlugin(const FlutterLibphonenumberWindowsPlugin&) = delete;
  FlutterLibphonenumberWindowsPlugin& operator=(const FlutterLibphonenumberWindowsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_libphonenumber_windows

#endif  // FLUTTER_PLUGIN_FLUTTER_LIBPHONENUMBER_WINDOWS_PLUGIN_H_
