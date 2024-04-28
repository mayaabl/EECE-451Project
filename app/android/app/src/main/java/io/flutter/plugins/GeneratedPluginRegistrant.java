package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.androidintent.AndroidIntentPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin android_intent, io.flutter.plugins.androidintent.AndroidIntentPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.androidintent.AndroidIntentPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin android_intent_plus, dev.fluttercommunity.plus.androidintent.AndroidIntentPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin permission_handler_android, com.baseflow.permissionhandler.PermissionHandlerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.tekartik.sqflite.SqflitePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin sqflite, com.tekartik.sqflite.SqflitePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.shounakmulay.telephony.TelephonyPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin telephony, com.shounakmulay.telephony.TelephonyPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.wifi_info_flutter.WifiInfoFlutterPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin wifi_info_flutter, io.flutter.plugins.wifi_info_flutter.WifiInfoFlutterPlugin", e);
    }
  }
}
