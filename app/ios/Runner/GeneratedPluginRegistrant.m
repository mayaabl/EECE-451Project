//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

#if __has_include(<telephony/TelephonyPlugin.h>)
#import <telephony/TelephonyPlugin.h>
#else
@import telephony;
#endif

#if __has_include(<wifi_info_flutter/WifiInfoFlutterPlugin.h>)
#import <wifi_info_flutter/WifiInfoFlutterPlugin.h>
#else
@import wifi_info_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [TelephonyPlugin registerWithRegistrar:[registry registrarForPlugin:@"TelephonyPlugin"]];
  [WifiInfoFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"WifiInfoFlutterPlugin"]];
}

@end
