import 'package:geolocator/geolocator.dart';

class LocationClass {

  static Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  static Future<void> enableLocationService() async {
    await Geolocator.openLocationSettings();
  }

  static Future<dynamic> getLocation() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
        return position;
     
    } else {
      return null;
    }
  }
}
