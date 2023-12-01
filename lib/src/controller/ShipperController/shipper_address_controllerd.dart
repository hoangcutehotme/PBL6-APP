import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ShipperAddressController extends GetxController {
  final Completer<GoogleMapController> controllerMap = Completer();

  var marker = <Marker>{}.obs;
  Position? _locationShipper;
  Position? get locationShipper => _locationShipper;

  @override
  void onInit() {
    super.onInit();
    print("OnInit");
    determinePosition().then((value) => setLocationShipper(value!));
  }

  @override
  void onReady() {
    print('onready');
    super.onReady();
  }

  Future<Position?> determinePosition() async {
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
    _locationShipper = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    update();
    return _locationShipper;
  }

  Future<String?> getNamePosition(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'vi_VN');
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

  setLocationShipper(Position position) async {
    var url =
        "${ApiEndPoints.baseUrl}/shipper/654fadcef9dbb10008002b48/lat/${position.latitude}/lng/${position.longitude}";
    ApiClient apiClient = Get.find();
    try {
      var response = await http.post(Uri.parse(url), headers: apiClient.header);
      if (response.statusCode == 200) {
      } else {
        print('Not update location shipper');
      }
    } catch (e) {
      print('Not update location shipper');
    }
  }
}
