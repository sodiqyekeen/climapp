import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getLocation() async {
    if (await ensureLocationAccessIsGranted()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> ensureLocationAccessIsGranted() async {
    if (await Permission.locationWhenInUse.isGranted) {
      return true;
    } else {
      PermissionStatus status = await Permission.locationWhenInUse.request();
      return status == PermissionStatus.granted;
    }
  }
}
