import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/StoreController/cart_controller.dart';
import 'package:pbl6_app/src/controller/StoreController/store_detail_controller.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/controller/func/func_useful.dart';
import 'package:pbl6_app/src/model/product_model.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/image_loading_network.dart';
import 'package:pbl6_app/src/widgets/skelton.dart';

import '../../utils/custome_dialog.dart';
import '../../widgets/food_cell.dart';

class DetailShop extends StatefulWidget {
  const DetailShop({super.key});

  @override
  State<DetailShop> createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  bool showTitle = false;
  bool showCart = false;
  ScrollController? _scrollController;
  String storeId = '';

  @override
  void initState() {
    super.initState();
    storeId = Get.arguments;

    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.offset >= 145) {
        setState(() {
          showTitle = true;
        });
      } else {
        setState(() {
          showTitle = false;
        });
      }
    });
  }

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    StoreDetailController storeController = Get.put(StoreDetailController());
    CartController cartController = Get.put(CartController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: bottomCart(cartController),
      body: GetBuilder<StoreDetailController>(
        initState: (_) => storeController.updateStore(storeId),
        builder: (_) {
          StoreModel store = storeController.store;
          List<ProductModel> products = storeController.listProduct;

          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              _FlexibleHeadBar(showTitle: showTitle, store: store),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _InfoShop(store, size),
                  ],
                ),
              ),
              _listProductStore(products, cartController)
            ],
          );
        },
      ),
    );
  }

  GetBuilder<CartController> _listProductStore(
      List<ProductModel> products, CartController cartController) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CartController>(builder: (_) {
      if (products.isEmpty) {
        Future.delayed(const Duration(seconds: 10)).then(
          (value) {
            return const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                      child: Text(
                    "Hiện tại chưa có món ăn",
                    style: AppStyles.textMedium,
                  )),
                ],
              ),
            );
          },
        );
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                height: 140,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Skelton(
                      width: 160,
                      height: 120,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skelton(
                              width: size.width * 0.5,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Skelton(
                              width: 120,
                            ),
                            Expanded(child: Container()),
                            const Row(
                              children: [
                                Skelton(
                                  width: 100,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            childCount: 4,
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/detailfood', arguments: products[index]);
                },
                child: FoodInfoCell(
                  controller: cartController,
                  product: products[index],
                ),
              );
            },
            childCount: products.length,
          ),
        );
      }
    });
  }

  _InfoShop(StoreModel store, Size size) {
    if (store.name != null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  "Yêu thích",
                  style: AppStyles.textBold
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  store.name ?? '',
                  style: AppStyles.textBold.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              const Icon(Icons.star_outlined, color: Colors.amber),
              Text(
                (store.ratingAverage ?? 0).toString(),
                style: AppStyles.textMedium,
              ),
              // const Text(" (100+ Bình luận)", style: AppStyles.textMedium),
              Text(
                " | ",
                style: AppStyles.textMedium
                    .copyWith(fontSize: 20, color: AppColors.borderGray),
              ),
              const Icon(
                Icons.access_time,
                color: AppColors.mainColor1,
              ),

              Text(" ${store.openAt.toString()} - ${store.closeAt.toString()}",
                  style: AppStyles.textMedium),
              Expanded(child: Container()),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8)), // Optional: customize button shape
                  ),
                  child: Image.asset(
                    'assets/icons/heartIcon.png', // Path to your image asset
                    width: 32, // Width of the image icon
                    height: 32, // Height of the image icon
                    color: AppColors
                        .borderGray, // Optional: change the color of the image icon
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.mainColor1,
              ),
              Flexible(
                child: Text(
                  store.address.toString(),
                  style: AppStyles.textMedium,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.phone,
                color: AppColors.mainColor1,
              ),
              Flexible(
                child: Text(
                  store.phoneNumber.toString(),
                  style: AppStyles.textMedium,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 10,
          color: AppColors.placeholder,
        )
      ]);
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  "Yêu thích",
                  style: AppStyles.textBold
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Skelton(
                width: 160,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              const Skelton(
                width: 120,
              ),
              Expanded(child: Container()),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8)), // Optional: customize button shape
                  ),
                  child: Image.asset(
                    'assets/icons/heartIcon.png', // Path to your image asset
                    width: 32, // Width of the image icon
                    height: 32, // Height of the image icon
                    color: AppColors
                        .borderGray, // Optional: change the color of the image icon
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Skelton(
                width: size.width - 30,
              )),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Skelton(
                width: 110,
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 10,
          color: AppColors.placeholder,
        )
      ]);
    }
  }

  bottomCart(CartController controller) {
    return GetBuilder<CartController>(
      builder: (_) {
        return controller.checkShowCart()
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderGray)),
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Badge(
                                  label: Text(
                                      controller.products.length.toString()),
                                  child: Image.asset(
                                    AppAssets.getImg("bag_cart.png", "icons"),
                                    color: AppColors.mainColor1,
                                    width: 32,
                                    height: 32,
                                  ),
                                )),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${FuncUseful.formartStringPrice(controller.productTotal())}đ',
                                  style: AppStyles.textMedium.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ]),
                    ),
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            if (userController.id.value == "") {
                              CustomeDialog.showCustomDialog1(
                                context: Get.context,
                                title: 'Thông báo',
                                message: 'Bạn chưa đăng nhập - Đăng nhập ngay ',
                                pressConfirm: () {
                                  Get.toNamed("/signin");
                                },
                              );
                            } else {
                              Get.toNamed("/detailorder");
                            }
                          },
                          child: Container(
                            height: 58,
                            alignment: Alignment.center,
                            color: AppColors.mainColor1,
                            child: Text(
                              "Thanh toán",
                              style: AppStyles.textBoldButton
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            : Container(
                height: 0,
              );
      },
    );
  }
}

class _FlexibleHeadBar extends StatelessWidget {
  const _FlexibleHeadBar({
    required this.showTitle,
    required this.store,
  });
  final bool showTitle;
  final StoreModel? store;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true, // Set this to true to make the app bar sticky
      floating:
          false, // Set this to false to keep the app bar visible even when scrolling down
      expandedHeight: 200,

      leading: Container(
        decoration: showTitle
            ? null
            : const BoxDecoration(
                shape: BoxShape.circle, color: Colors.transparent),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: showTitle ? AppColors.mainColor1 : Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      actions: showTitle
          ? null
          : [
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              )
            ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          bottom: 5,
          left: 50,
        ),
        title: showTitle
            ? Container(
                height: 46,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: AppColors.placeholder,
                ),
                child: const Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 1),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: 'Tìm kiếm',
                    ),
                  ),
                ),
              )
            : null,
        background: Opacity(
            opacity: 1,
            child: ImageLoadingNetwork(
                image: store!.image ?? '', size: Size(context.width, 200))),
      ), // Set the height of the app bar when it is expanded
    );
  }
}
