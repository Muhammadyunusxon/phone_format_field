#include "include/flutter_libphonenumber_windows/flutter_libphonenumber_windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_libphonenumber_windows_plugin.h"

void FlutterLibphonenumberWindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_libphonenumber_windows::FlutterLibphonenumberWindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
