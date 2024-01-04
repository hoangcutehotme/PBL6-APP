import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbl6_app/src/controller/OrderController/order_shipper_controller.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_address_controllerd.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/helper/func/func_useful.dart';
import 'package:pbl6_app/src/model/shipper_order.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:pbl6_app/src/values/app_values.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../model/order_detail_shipper.dart';
import '../../../utils/custome_dialog.dart';
import '../../../utils/custome_snackbar.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_string.dart';
import '../../../values/app_styles.dart';
import 'order_detail_shipper_screen.dart';

class ShipperHomePage extends StatefulWidget {
  const ShipperHomePage({super.key});

  @override
  State<ShipperHomePage> createState() => _ScreenDetailOrderAndShipperState();
}

class _ScreenDetailOrderAndShipperState extends State<ShipperHomePage> {
  final ShipperAddressController _addressShipperController =
      Get.put(ShipperAddressController());
  late Completer<GoogleMapController> _controllerMap;

  ShipperController shipperController = Get.find();
  OrderShipperController orderShipperController = Get.put(
      OrderShipperController(
          orderRepo: Get.find(), shipperController: Get.find()));

  Map<PolylineId, Polyline> polylines = {};

  PolylinePoints polylinePoints = PolylinePoints();

  @override
  initState() {
    _controllerMap = _addressShipperController.controllerMap;
    super.initState();
  }

  @override
  void dispose() {
    _controllerMap = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var panelHeightClose = AppValues.APP_VALUES_HEIGHT_MIN_BOTTOM_SHEET;
    // var panelHeightExpand = size.height * 0.6.toDouble();
    return Scaffold(
      body: GetBuilder<ShipperController>(
        builder: (_) {
          var panelHeightExpand = shipperController.currentOrder.id != null
              ? size.height * 0.65
              : 320.0;
          return SlidingUpPanel(
            backdropTapClosesPanel: true,
            minHeight: panelHeightClose,
            maxHeight: panelHeightExpand,
            body: Stack(
              children: [
                GetBuilder<ShipperAddressController>(builder: (_) {
                  var positionShipper =
                      _addressShipperController.currentLocation;
                  return Stack(
                    children: [
                      positionShipper == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : _googleMap(positionShipper)
                    ],
                  );
                }),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            panelBuilder: (controller) {
              // Panel content based on conditions
              return GetBuilder<ShipperController>(
                initState: (state) =>
                    shipperController.getListOrderNearShipper(),
                builder: (_) {
                  return shipperController.currentOrder.id == null ||
                          shipperController.currentOrder.status == "Refused"
                      ? _panelWidget(controller)
                      : _panelWidgetOrder(controller);
                },
              );
            },
          );
        },
      ),
    );
  }

  _panelWidgetOrder(ScrollController controller) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
          child: Stack(
            children: [
              Center(
                  child: Text(
                'Đơn hàng hiện tại',
                style: AppStyles.textBold.copyWith(fontSize: 18),
              )),
            ],
          ),
        ),
        GetBuilder<ShipperController>(builder: (_) {
          var currentOrder = shipperController.currentOrder;
          var user = currentOrder.user;
          var store = currentOrder.store;

          if (currentOrder.id == null) {
            return FutureBuilder(
              future: Future.delayed(const Duration(seconds: 5)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text("Hiện tại không có đơn hàng"),
                  );
                }
              },
            );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trạng thái',
                          style: AppStyles.textSemiBold,
                        ),
                        Text(FuncUseful.formatStatus(currentOrder.status),
                            style: AppStyles.textSemiBold)
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cửa hàng: ',
                                style:
                                    AppStyles.textBold.copyWith(fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _addressShipperController.animateToLocation(
                                        currentOrder
                                            .storeLocation!.coordinates[0],
                                        currentOrder
                                            .storeLocation!.coordinates[1]);
                                  },
                                  icon: const Icon(
                                    Icons.my_location_outlined,
                                    color: AppColors.colorDirectionToStore,
                                  ))
                            ],
                          ),
                          Text(
                            '${store?.name} ',
                            style: AppStyles.textBold.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            store?.address ?? '',
                            style: AppStyles.textMedium
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Giao đến: ',
                                style:
                                    AppStyles.textBold.copyWith(fontSize: 16),
                              ),
                              IconButton.filled(
                                  onPressed: () {
                                    _addressShipperController.animateToLocation(
                                        currentOrder
                                            .contact!.location!.coordinates![0],
                                        currentOrder.contact!.location!
                                            .coordinates![1]);
                                  },
                                  icon: const Icon(
                                    Icons.my_location_outlined,
                                    color: AppColors.colorDirectionToCustomer,
                                  ))
                            ],
                          ),
                          Text(
                            '${user?.lastName} ${user?.firstName} - ${currentOrder.contact!.phoneNumber}',
                            style: AppStyles.textBold.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            currentOrder.contact?.address ?? '',
                            style: AppStyles.textMedium
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (currentOrder.id != null) {
                        Get.to(() => const OrderDetailShipperScreen(),
                            arguments: currentOrder.id);
                      } else {
                        CustomeSnackBar.showWarningTopBar(
                            context: Get.context,
                            title: 'Thông báo',
                            message: 'Hiện không thể nhận đơn này');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
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
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: _buttonStatusOrder(currentOrder),
                  )
                ]);
          }
        })
      ],
    );
  }

  _buttonStatusOrder(OrderDetailShipper detailOrder) {
    return GetBuilder<OrderShipperController>(builder: (_) {
      return detailOrder.status == AppString.statusOrder.keys.elementAt(0) ||
              detailOrder.status == AppString.statusOrder.keys.elementAt(1)
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                backgroundColor: AppColors.mainColor1,
              ),
              onPressed: () {
                CustomeDialog.showCustomeDialog(
                    context: Get.context,
                    title: '',
                    message: 'Bạn có muốn nhận đơn không ???',
                    confirmText: 'Có',
                    pressConfirm: () {
                      orderShipperController.changeStatusOrder(detailOrder.id!);

                      Get.back();
                    });
              },
              child: Text('Xác nhận nhận đơn',
                  style: AppStyles.textSemiBold
                      .copyWith(color: AppColors.mainColorBackground)))
          : detailOrder.status == AppString.statusOrder.keys.elementAt(2)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    backgroundColor: AppColors.mainColor1,
                  ),
                  onPressed: () {
                    orderShipperController
                        .changeStatusOrder(detailOrder.id!)
                        .then((value) => CustomeSnackBar.showSuccessSnackTopBar(
                            context: Get.context,
                            title: 'Success',
                            message: 'Xác nhận đã nhận hàng'));
                  },
                  child: Text(
                    'Đã nhận hàng từ cửa hàng',
                    style: AppStyles.textSemiBold
                        .copyWith(color: AppColors.mainColorBackground),
                  ))
              : detailOrder.status == AppString.statusOrder.keys.elementAt(3)
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        backgroundColor: AppColors.mainColor1,
                      ),
                      onPressed: () async {
                        orderShipperController
                            .changeStatusOrder(detailOrder.id!)
                            .then((value) =>
                                CustomeSnackBar.showSuccessSnackTopBar(
                                    context: Get.context,
                                    title: 'Success',
                                    message: 'Đã hoàn thành giao hàng'));
                        await shipperController.getListOrderNearShipper();
                        Get.find<ShipperAddressController>().setMarkerShipper();
                      },
                      child: Text('Xác nhận đã giao hàng thành công',
                          style: AppStyles.textSemiBold
                              .copyWith(color: AppColors.mainColorBackground)))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        backgroundColor: AppColors.mainColor1,
                      ),
                      onPressed: () async {
                        Get.find<ShipperAddressController>().setMarkerShipper();
                        await _addressShipperController.setLocationShipper();
                        await shipperController.getListOrderNearShipper();
                      },
                      child: Text('Tìm kiếm đơn khác',
                          style: AppStyles.textSemiBold
                              .copyWith(color: AppColors.mainColorBackground)));
    });
  }

  _panelWidget(ScrollController controller) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Stack(
            children: [
              Center(
                  child: Text(
                'Đơn hàng',
                style: AppStyles.textBold.copyWith(fontSize: 18),
              )),
              Positioned(
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      shipperController.getListOrderNearShipper();
                    },
                    icon: const Icon(Icons.refresh),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: GetBuilder<ShipperController>(builder: (_) {
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
                    return const Center(
                      child: Text("Hiện tại không có đơn hàng gần đây"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mã đơn hàng',
                      style: AppStyles.textMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${(order.dist! / 1000).toStringAsFixed(2)} km',
                      style: AppStyles.textMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorSuccess),
                    )
                  ],
                ),
                Text(
                  '${order.id}',
                  style: AppStyles.textMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Trạng thái : ${FuncUseful.formatStatus(order.status)}',
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500),
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
                Row(
                  children: [
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
                          Text(
                            'Xem chi tiết',
                            style: AppStyles.textMedium
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _addressShipperController.setMarkerShipper();

                        await _addressShipperController.animateToLocation(
                            order.storeLocation!.coordinates![0],
                            order.storeLocation!.coordinates![1]);
                        await _addressShipperController.setMarker(
                            "locationStore",
                            _addressShipperController.storeIcon.value,
                            order.storeLocation!.coordinates![0],
                            order.storeLocation!.coordinates![1],
                            "Cửa hàng ở đây");
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.colorDirectionToStore,
                            size: 30,
                          ),
                          Text(
                            'Địa chỉ quán',
                            style: AppStyles.textMedium
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor1),
            onPressed: () {
              if (order.id != null) {
                Get.to(() => const OrderDetailShipperScreen(),
                    arguments: order.id);
              } else {
                CustomeSnackBar.showWarningTopBar(
                    context: Get.context,
                    title: 'Thông báo',
                    message: 'Không thể nhận đơn này');
              }
            },
            child: Text(
              'Nhận đơn',
              style: AppStyles.textBoldButton
                  .copyWith(fontWeight: FontWeight.w500),
            ))
      ],
    );
  }

  _currentAddress(Size size, userPosition) {
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
          future: _addressShipperController.getNamePosition(userPosition),
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

  _googleMap(userPosition) {
    return GetBuilder<ShipperAddressController>(builder: (_) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 15,
        ),
        myLocationEnabled: true,
        polylines: Set<Polyline>.of(_addressShipperController.polylines.values),
        markers: _addressShipperController.marker.toSet(),
        onMapCreated: (GoogleMapController controller) {
          if (!_controllerMap.isCompleted) {
            _controllerMap.complete(controller);
          }
        },
      );
    });
  }
}
