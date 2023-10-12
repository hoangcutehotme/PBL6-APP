import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/food_model.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/screens/homeScreen/detail_food.dart';
import 'package:pbl6_app/src/screens/navigation/HomeMainPage.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import '../../widgets/food_cell.dart';

class DetailShop extends StatefulWidget {
  const DetailShop({super.key});

  @override
  State<DetailShop> createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  bool showTitle = false;
  bool showCart = false;
  int count = 0;
  ScrollController? _scrollController;
  List<StoreModel> stories = [];
  List<FoodModel> listfood = [];
  Set<String>? listCategory;

  late StoreModel store;

  void getStories() {
    stories = StoreModel.getListStore();
    store = stories[0];
    listfood = store.listFood.reversed.toList();
    listCategory = listfood.map((food) => food.nameCategory).toSet();
    print(listCategory);
  }

  @override
  void initState() {
    super.initState();

    getStories();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showCart ? _showCartOrder() : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          _FlexibleHeadBar(showTitle: showTitle),
          _InfoShop(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => const DetailFood());
                  },
                  child: FoodInfoCell(
                    food: listfood[index],
                    count: 0,
                    pressPlus: () {
                      setState(() {
                        count++;
                        showCart = count > 0 ? true : false;
                      });
                    },
                    pressMinus: () {
                      setState(() {
                        count--;
                        showCart = count > 0 ? true : false;
                      });
                    },
                  ),
                );
              },
              childCount:
                  listfood.length, // Set the number of items in your list
            ),
          ),
        ],
      ),
    );
  }

  Container _showCartOrder() {
    return Container(
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
                        label: Text(count.toString()),
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
                    child: Text("Thanh toan $count"),
                  ),
                ]),
          ),
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {},
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
    );
  }

  SliverToBoxAdapter _InfoShop() {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Text(
                "Bún đậu cô Tiên",
                style: AppStyles.textBold.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 20),
          child: Row(
            children: [
              const Icon(Icons.star_outlined, color: Colors.amber),
              Text(
                stories[0].ratingAverage.toString(),
                style: AppStyles.textMedium,
              ),
              const Text(" (100+ Bình luận)", style: AppStyles.textMedium),
              Text(
                " | ",
                style: AppStyles.textMedium
                    .copyWith(fontSize: 20, color: AppColors.borderGray),
              ),
              const Icon(
                Icons.location_on,
                color: AppColors.mainColor1,
              ),
              Text("${stories[0].distance.toString()} km",
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
        Container(
          height: 10,
          color: AppColors.placeholder,
        )
      ]),
    );
  }
}

class _FlexibleHeadBar extends StatelessWidget {
  const _FlexibleHeadBar({
    required this.showTitle,
  });

  final bool showTitle;

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
          child: Image.asset(
            AppAssets.bundauImage,
            fit: BoxFit.fill,
          ),
        ),
      ), // Set the height of the app bar when it is expanded
    );
  }
}

class MyHeaderTitle extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    throw UnimplementedError();
  }

  @override
  double get maxExtent => throw UnimplementedError();

  @override
  double get minExtent => throw UnimplementedError();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
