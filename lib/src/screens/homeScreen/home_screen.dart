import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/CategoryControler/category_controller.dart';
import 'package:pbl6_app/src/model/food_category_model.dart';
import 'package:pbl6_app/src/model/food_model.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import '../../values/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController _categoryController = Get.put(CategoryController());

  List<CategoryModel> categories = [];
  List<StoreModel> stories = [];
  List<FoodModel> foodList = [];

  // void getCategories() {
  //   categories = CategoryModel.getCategories();
  // }

  void getStories() {
    stories = StoreModel.getListStore();
  }

  void getFoodList() {
    foodList = FoodModel.getFoods();
  }

  @override
  void initState() {
    // getCategories();
    getStories();
    getFoodList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainColorBackground,
            shadowColor: Colors.transparent,
            pinned: true,
            collapsedHeight: 110,
            flexibleSpace: Column(children: [
              const SizedBox(
                height: 25,
              ),
              _addressSection(),
              const SizedBox(
                height: 5,
              ),
              //Search
              _searchSection(size),
            ]),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                _categorySection(),
                // Store
                _storeSection(),
                // Food Special
                _foodSection()
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _foodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Deal Hời",
            style: AppStyles.textBold.copyWith(fontSize: 22),
          ),
        ),
        Container(
            width: double.infinity,
            height: 240,
            padding: const EdgeInsets.only(left: 20),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: foodList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                  width: 180,

                  // padding: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                      // color: AppColors.mainColor1,
                      // borderRadius: BorderRadius.circular(10),
                      ),
                  child: GestureDetector(
                    onTap: () {
                      //to detail view
                      Get.toNamed("/detailshop");
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            foodList[index].imageFood,
                            width: 160,
                            height: 140,
                            fit: BoxFit.fill,

                            // color: AppColors.borderGray,
                          ),
                        ),
                        Positioned(
                          top: 130,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Text(
                              "Freeship",
                              style: AppStyles.textBold.copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          left: 10,
                          child: Text(
                            foodList[index].name,
                            maxLines: 1,
                            style: AppStyles.textBold.copyWith(fontSize: 16),
                          ),
                        ),
                        Positioned(
                          top: 175,
                          child: Text(
                            "${foodList[index].price.toInt().toString()}đ",
                            style: AppStyles.textBold.copyWith(
                                fontSize: 16, color: AppColors.mainColor1),
                            // textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }

  Column _storeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Quán ăn mới nổi",
            style: AppStyles.textBold.copyWith(fontSize: 22),
          ),
        ),
        Container(
            // color: Colors.amber,
            width: double.infinity,
            height: 240,
            padding: const EdgeInsets.only(left: 20),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                  width: 240,
                  decoration: const BoxDecoration(
                      // color: AppColors.mainColor1,
                      // borderRadius: BorderRadius.circular(10),
                      ),
                  child: GestureDetector(
                    onTap: () {
                      //to detail view
                      Get.toNamed("/detailshop");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            stories[index].image,
                            width: 240,
                            height: 160,
                            fit: BoxFit.fill,

                            // color: AppColors.borderGray,
                          ),
                        ),
                        Text(
                          stories[index].name,
                          maxLines: 1,
                          style: AppStyles.textBold.copyWith(fontSize: 18),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_outlined,
                                color: Colors.amber),
                            Text(
                              stories[index].ratingAverage.toString(),
                              style: AppStyles.textMedium,
                            ),
                            Text(
                              " | ",
                              style: AppStyles.textMedium.copyWith(
                                  fontSize: 20, color: AppColors.borderGray),
                            ),
                            const Icon(
                              Icons.location_on,
                              color: AppColors.mainColor1,
                            ),
                            Text("${stories[index].distance.toString()} km",
                                style: AppStyles.textMedium),
                            Text(
                              " | ",
                              style: AppStyles.textMedium.copyWith(
                                  fontSize: 20, color: AppColors.borderGray),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }

  Padding _searchSection(Size size) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
      child: GestureDetector(
        child: Container(
          width: size.width,
          height: 45,
          decoration: const ShapeDecoration(
              shape: StadiumBorder(), color: AppColors.placeholder),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(width: 2, color: AppColors.borderGray)),
          child: TextField(
            onTap: () {
              Get.toNamed("/search");
              // Get.to(const OrderScreen());
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Tìm kiếm'),
          ),
        ),
      ),
    );
  }

  Column _addressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Text(
            "Giao đến",
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: GestureDetector(
            child: const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.mainColor1,
                ),
                Text("Address"),
              ],
            ),
            onTap: () {
              // Show search location
            },
          ),
        ),
      ],
    );
  }

  Column _categorySection() {
    List<CategoryModel> categories = _categoryController.listCategory;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          "Danh mục",
          style: AppStyles.textBold.copyWith(fontSize: 22),
        ),
      ),
      Obx(() {
        return Container(
            width: double.infinity,
            height: 140,
            padding: const EdgeInsets.only(left: 20),
            child: _categoryController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            //to detail view
                            // String encodedCatName =
                            //     Uri.encodeComponent(categories[index].catName);
                            Get.toNamed("/detailcategory",
                                arguments: categories[index]);
                          },
                          child: Column(
                            children: [
                              // Text(categories[index].id),
                              Image.asset(
                                // categories[index].imgPath ??
                                AppAssets.getImg('food.png', 'images'),
                                width: 120,
                                height: 100,
                              ),
                              Text(categories[index].catName)
                            ],
                          ),
                        ),
                      );
                    }));
      }),
    ]);
  }
}
