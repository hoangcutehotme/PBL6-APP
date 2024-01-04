import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:location/location.dart' as flutterlocation;

class ShipperAddressController extends GetxController {
  Completer<GoogleMapController> controllerMap = Completer();

  var marker = <Marker>{}.obs;

  flutterlocation.LocationData? _currentLocation;
  flutterlocation.LocationData? get currentLocation => _currentLocation;

  flutterlocation.Location location = flutterlocation.Location();

  final List<LatLng> _polylineCoordinate = [];
  List<LatLng> get polylineCoordinate => _polylineCoordinate;

  final Map<PolylineId, Polyline> _polylines = {};
  Map<PolylineId, Polyline> get polylines => _polylines;

  PolylinePoints polylinePoints = PolylinePoints();

  Rx<BitmapDescriptor> storeIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed).obs;
  Rx<BitmapDescriptor> userIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue).obs;
  Rx<BitmapDescriptor> shipperIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await determinePosition();
    // await setMarkerIcon();
    await setMarkerShipper();
    await setLocationShipper();
  }

  setMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/store_icon.png")
        .then((value) => storeIcon.value = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/user_avartar2.png.png")
        .then((value) => userIcon.value = value);

    update();
  }

  determinePosition() async {
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
    // await animateCurrentLocation();
    await getCurrentLocation();
  }

  Future<String?> getNamePosition(flutterlocation.LocationData position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude!, position.longitude!,
        localeIdentifier: 'vi_VN');
    return placemarks[0].street;
  }

  clearMarker() {
    marker.removeWhere(
        (marker) => marker.markerId != const MarkerId('shipperLocation'));

    update();
  }

  setMarkerShipper() async {
    clearMarker();

    marker.add(Marker(
        infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
        markerId: const MarkerId('shipperLocation'),
        icon: shipperIcon.value,
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));

    update();
  }

  updateShipperLocation() async {
    marker.removeWhere(
        (marker) => marker.markerId == const MarkerId('shipperLocation'));
    marker.add(Marker(
        infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
        markerId: const MarkerId('shipperLocation'),
        icon: shipperIcon.value,
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));
  }

  setMarker(String idMarker, BitmapDescriptor icon, double lat, double long,
      String title) {
    marker.add(Marker(
        infoWindow: InfoWindow(snippet: title),
        markerId: MarkerId(idMarker),
        icon: icon,
        position: LatLng(lat, long)));
    update();
  }

  setMarkerCustomerAndStoreLocation() {
    clearMarker();

    marker.add(Marker(
        markerId: const MarkerId('addressDeliveryLocation'),
        icon: userIcon.value,
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));

    marker.add(Marker(
        markerId: const MarkerId('currentLocation'),
        icon: shipperIcon.value,
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));

    marker.add(Marker(
        markerId: const MarkerId("storeLocation"),
        icon: storeIcon.value,
        position: const LatLng(16.073985612738287, 108.14985671349393)));
  }

  setLocationShipper() async {
    await animateCurrentLocation();

    var url =
        "${ApiEndPoints.baseUrl}/shipper/654fadcef9dbb10008002b48/lat/${currentLocation!.latitude!}/lng/${currentLocation!.longitude}";
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

  removePolyPoints() {
    _polylines.clear();
    update();
  }

  getPolyPoints() async {
    try {
      PolylineResult polylineResult =
          await polylinePoints.getRouteBetweenCoordinates(
              AppString.API_KEY,
              const PointLatLng(16.06622184293232, 108.14579824066755),
              PointLatLng(
                  _currentLocation!.latitude!, _currentLocation!.longitude!));
      if (polylineResult.points.isNotEmpty) {
        for (var point in polylineResult.points) {
          _polylineCoordinate.add(LatLng(point.latitude, point.longitude));
        }
      }
      update();
    } catch (e) {
      print("Error $e");
    }
  }

  getDirectionToStoreAndUser() async {
    try {
      var order = Get.find<ShipperController>().currentOrder;

      List<LatLng> polylineCoordinatestoStore = [];
      List<LatLng> polylineCoordinatesStoretoCustomer = [];

      var storeLocation = order.storeLocation!.coordinates;

      var userLocation = order.contact!.location!.coordinates;

      await setMarkerShipper();

      setMarker("storeLocation", storeIcon.value, storeLocation[0],
          storeLocation[1], 'Cửa hàng');

      setMarker("customerLocation", userIcon.value, userLocation![0],
          userLocation[1], 'Điểm giao');

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppString.API_KEY,
        PointLatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        PointLatLng(storeLocation[0], storeLocation[1]),
        travelMode: TravelMode.transit,
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinatestoStore
              .add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print("Error polyline1 >>>>>> ");
        print(result.errorMessage);
      }

      addPolyLine(polylineCoordinatestoStore, AppColors.colorDirectionToStore,
          "toStore");

      await Future.delayed(const Duration(seconds: 3));

      PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
        AppString.API_KEY,
        PointLatLng(storeLocation[0], storeLocation[1]),
        PointLatLng(userLocation[0], userLocation[1]),
        travelMode: TravelMode.transit,
      );

      if (result2.points.isNotEmpty) {
        for (var point in result2.points) {
          polylineCoordinatesStoretoCustomer
              .add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print("Error polyline2 >>>>>> ");
        print(result.errorMessage);
      }

      addPolyLine(polylineCoordinatesStoretoCustomer,
          AppColors.colorDirectionToCustomer, "storeToCustomer");
    } catch (e) {
      print("Error polyline");
      print(e);
    }
  }

  getCurrentLocation() async {
    await location.getLocation().then((location) {
      _currentLocation = location;
      update();
    });
  }

  updateMarkerShipper() {}

  animateCurrentLocation() async {
    GoogleMapController googleMapController = await controllerMap.future;

    location.onLocationChanged.listen((location) {
      if (_currentLocation == location) {
        print('not change');
        return;
      } else {
        print('change');
        _currentLocation = location;
        updateShipperLocation();

        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 15,
                target: LatLng(location.latitude!, location.longitude!))));

        update();
      }
    });
  }

  animateToLocation(double lat, double long) async {
    GoogleMapController googleMapController = await controllerMap.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, target: LatLng(lat, long))));
    update();
  }

  addPolyLine(List<LatLng> polylineCoordinates, Color color, String idString) {
    PolylineId id = PolylineId(idString);

    Polyline polyline = Polyline(
      polylineId: id,
      color: color,
      points: polylineCoordinates,
      width: 5,
    );
    _polylines[id] = polyline;
    update();
  }

  setAnimationCurrentMap() async {
    // await getCurrentLocation();
    await animateCurrentLocation();
  }
}
