import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/AddressController/address_user_controller.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';

class ShipperHomePage extends StatefulWidget {
  const ShipperHomePage({super.key});

  @override
  State<ShipperHomePage> createState() => _ScreenDetailOrderAndShipperState();
}

class _ScreenDetailOrderAndShipperState extends State<ShipperHomePage> {
  final AddressUserController _addressUserController =
      Get.put(AddressUserController());
  late Completer<GoogleMapController> _controllerMap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerMap = _addressUserController.controllerMap;
  }
  @override
  void dispose() {
    _controllerMap = Completer();
    super.dispose();
  }
  static const CameraPosition _kLake =
      CameraPosition(target: LatLng(16.0739, 108.1499), zoom: 17);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<Position>(
        future: _addressUserController.determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show error message if there is an error determining user's position
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // User's position successfully determined, update the UI
            Position userPosition = snapshot.data!;
            _addressUserController.setNewMarkerLocation(userPosition);

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userPosition.latitude, userPosition.longitude),
                    zoom: 18,
                  ),
                  markers: _addressUserController.marker.toSet(),
                  onMapCreated: (GoogleMapController controller) {
                    _controllerMap.complete(controller);
                  },
                ),
                Positioned(
                  left: size.width * 0.1,
                  top: 20,
                  child: Container(
                    width: size.width * 0.8,
                    height: 50,
                    color: AppColors.mainColorBackground,
                    child: FutureBuilder<String?>(
                      future:
                          _addressUserController.getNamePosition(userPosition),
                      builder: (context, nameSnapshot) {
                        if (nameSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Show loading indicator while fetching street name
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (nameSnapshot.hasError) {
                          // Show error message if there is an error fetching street name
                          return Center(
                              child: Text('Error: ${nameSnapshot.error}'));
                        } else {
                          // Street name successfully fetched, update the UI
                          String streetName = nameSnapshot.data ?? '';
                          return Center(
                            child: Text(
                              streetName,
                              style: AppStyles.textMedium,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                // BottomSheet(onClosing: (){

                // }, builder: builder)
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _addressUserController.determinePosition().then((value) async {
            print('Address : ' +
                value.latitude.toString() +
                " " +
                value.longitude.toString());

            _addressUserController.setCameraToNewLocation(value);
            _addressUserController.setNewMarkerLocation(value);
          });
        },
        child: const Icon(Icons.my_location_rounded),
      ),
    );
  }
}
