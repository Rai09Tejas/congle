import 'package:get/get.dart';
import 'package:location/location.dart';

Future<LocationData?> getLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  await Future.delayed(500.milliseconds);

  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    await Future.delayed(500.milliseconds);

    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  locationData = await location.getLocation();
  return locationData;
}
