import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressUserController extends GetxController {
  final Completer<GoogleMapController> controllerMap = Completer();

  var marker = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // determinePosition();
  }
  // var locationCurrent = Rx<LatLng>.obs;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        
  }

  Future<String?> getNamePosition(Position position) async {
    String name = '';

    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'vi_VN');
    print(placemarks);
    return placemarks[0].street;
  }

  setNewMarkerLocation(Position position) {
    marker.clear();

    marker.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude)));
  }

  setCameraToNewLocation(Position position) async {
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18);

    final GoogleMapController controller = await controllerMap.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}

searchLocation() {
  List<String> location = [];
  
  return location;
}
