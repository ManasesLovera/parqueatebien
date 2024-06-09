# flutter_native_splash: ^2.4.0
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
import 'package:flutter_native_splash/flutter_native_splash.dart';
# flutter_screenutil: ^5.9.1
flutter pub add flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
# image_picker
flutter pub add image_picker
import 'package:image_picker/image_picker.dart';
# geolocator: ^11.0.0
flutter pub add geolocator
import 'package:geolocator/geolocator.dart';
#  logger: ^2.2.0
dart pub add logger
flutter pub add logger
import 'package:logger/logger.dart';
# permission_handler: ^11.3.1
flutter pub add permission_handler
import 'package:permission_handler/permission_handler.dart';

# pubspec.yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: false
  image_path: "assets/ic_icon.png"
  min_sdk_android: 21

flutter:
  uses-material-design: true

  assets:
    - assets/splash/back.png
    - assets/splash/bottom.png
    - assets/splash/main.png
    - assets/launcher_android_12+/main_splash.png
    - assets/launcher_android_-11/ic_icon.png
    - assets/whiteback/main_w.png

# Android Location permitionss
  <uses-permission
        android:name="android.permission.ACCESS_FINE_LOCATION"/>
  <uses-permission
        android:name="android.permission.ACCESS_COARSE_LOCATION"/>

# Native Splash Screen -flutter_native_splash-production.yaml
flutter_native_splash:
  android: true
  web: false
  ios: false
  background_image_android: "assets/splash/back.png"
  background_image_dark_android: "assets/splash/back.png"
  image: "assets/splash/main.png"
  branding: "assets/splash/bottom.png"
  branding_mode: bottom
  fullscreen: true

  android_12:
    image: "assets/launcher_android_12+/main_splash.png"
    branding: "assets/splash/bottom.png"
    branding_mode: bottom
    color: "#099DD2"
    fullscreen: true




