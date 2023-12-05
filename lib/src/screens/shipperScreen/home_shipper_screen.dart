import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_address_controllerd.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/model/shipper_order.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../utils/custome_snackbar.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import 'order_detail_shipper_screen.dart';

class ShipperHomePage extends StatefulWidget {
  const ShipperHomePage({super.key});

  @override
  State<ShipperHomePage> createState() => _ScreenDetailOrderAndShipperState();
}

class _ScreenDetailOrderAndShipperState extends State<ShipperHomePage> {
  final ShipperAddressController _addressUserController =
      Get.put(ShipperAddressController());
  late Completer<GoogleMapController> _controllerMap;

  @override
  void initState() {
    super.initState();
    _controllerMap = _addressUserController.controllerMap;
  }

  @override
  void dispose() {
    _controllerMap = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final panelHeigtClose = size.height * 0.1;
    const panelHeigtExpand = 330.0;
    return Scaffold(
      body: FutureBuilder<Position?>(
        future: _addressUserController.determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show error message if there is an error determining user's position
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Position userPosition = snapshot.data!;
            _addressUserController.setNewMarkerLocation(userPosition);
            return SlidingUpPanel(
              backdropTapClosesPanel: false,
              minHeight: panelHeigtClose,
              maxHeight: panelHeigtExpand,
              body: Stack(
                children: [
                  _googleMap(userPosition),
                  _currentAddress(size, userPosition),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              panelBuilder: (controller) {
                return _panelWidget(controller);
              },
            );
          }
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     _addressUserController.determinePosition().then((value) async {
      //       print('Address : ' +
      //           value.latitude.toString() +
      //           " " +
      //           value.longitude.toString());

      //       _addressUserController.setCameraToNewLocation(value);
      //       _addressUserController.setNewMarkerLocation(value);
      //     });
      //   },
      //   child: const Icon(Icons.my_location_rounded),
      // ),
    );
  }

  ListView _panelWidget(ScrollController controller) {
    ShipperController shipperController = Get.find();
    return ListView(
      controller: controller,
      children: <Widget>[
        Center(
            child: Text(
          'Đơn hàng',
          style: AppStyles.textBold.copyWith(fontSize: 18),
        )),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: GetBuilder<ShipperController>(
              initState: (state) => shipperController.getListOrder(),
              builder: (_) {
                var listOrder = shipperController.listOrder;

                if (listOrder.isEmpty) {
                  return FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 5)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // return ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         backgroundColor: AppColors.mainColor1),
                        //     onPressed: () {
                        //       Get.to(() => const OrderDetailShipperScreen(),
                        //           arguments: "656aeb0634082744d44ababa");
                        //     },
                        //     child: const Text('Nhận đơn'));

                        return const Center(
                          child: Text("No order"),
                        );
                      }
                    },
                  );
                } else {
                  return PageView.builder(
                    itemCount: listOrder.length,
                    itemBuilder: (context, index) {
                      return _itemOrder(listOrder[index]);
                    },
                  );
                }
              }),
        )
      ],
    );
  }

  Widget _itemOrder(OrderShipper order) {
    Size size = MediaQuery.of(context).size;
    double sizeOfOrder = size.width * 0.8;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: sizeOfOrder,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: AppColors.borderGray)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mã đơn hàng',
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  ' ${order.id}',
                  style: AppStyles.textMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Trạng thái : ${order.statusShipper(order.status!)}',
                  style: AppStyles.textMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (order.id != null) {
                      Get.to(() => const OrderDetailShipperScreen(),
                          arguments: order.id);
                    } else {
                      CustomeSnackBar.showWarningTopBar(
                          context: Get.context,
                          title: 'Thông báo',
                          message: 'Hiện không thể nhận đơn này');
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.getImg('order_icon.png', 'icons'),
                        height: 30,
                        width: 30,
                      ),
                      const Text(
                        'Xem chi tiết',
                        style: AppStyles.textMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor1),
            onPressed: () {
              // if (order.id != null) {
              //   Get.to(() => const OrderDetailShipperScreen(),
              //       arguments: order.id);
              // } else {
              //   CustomeSnackBar.showWarningTopBar(
              //       context: Get.context,
              //       title: 'Thông báo',
              //       message: 'Không thể nhận đơn này');
              // }
            },
            child: const Text('Nhận đơn'))
      ],
    );
  }

  Positioned _currentAddress(Size size, Position userPosition) {
    return Positioned(
      left: size.width * 0.1,
      top: 20,
      child: Container(
        width: size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.mainColorBackground,
        ),
        child: FutureBuilder<String?>(
          future: _addressUserController.getNamePosition(userPosition),
          builder: (context, nameSnapshot) {
            if (nameSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (nameSnapshot.hasError) {
              return Center(child: Text('Error: ${nameSnapshot.error}'));
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
    );
  }

  GoogleMap _googleMap(Position userPosition) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(userPosition.latitude, userPosition.longitude),
        zoom: 18,
      ),
      markers: _addressUserController.marker.toSet(),
      onMapCreated: (GoogleMapController controller) {
        if (!_controllerMap.isCompleted) {
          _controllerMap.complete(controller);
        }
      },
    );
  }
}
