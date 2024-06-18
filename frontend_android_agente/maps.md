# packages ! 
# -> On terminal
flutter pub add google_maps_flutter
flutter pub add flutter_polyline_points
flutter pub add geolocator


# frontend_android\android\app\src\main\AndroidManifest.xml
android {
    defaultConfig {
        minSdkVersion 20
    }
}

# frontend_android\android\app\src\main\AndroidManifest.xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>