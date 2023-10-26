import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/CategoryControler/category_controller.dart';
import 'package:pbl6_app/src/controller/StoreController/store_controller.dart';
import 'package:pbl6_app/src/model/food_category_model.dart';
import 'package:pbl6_app/src/model/food_model.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import '../../model/store_model.dart';
import '../../values/app_colors.dart';
import '../../widgets/category_card.dart';
import '../../widgets/food_card.dart';
import '../../widgets/store_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final CategoryController _categoryController = Get.put(CategoryController());

  List<FoodModel> foodList = [];

  void getFoodList() {
    foodList = FoodModel.getFoods();
  }

  @override
  void initState() {
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
                return FoodCard(food: foodList[index]);
              },
            ))
      ],
    );
  }

  Column _storeSection() {
    StoreController storeController = Get.put(StoreController());
    List<StoreModel> stories = storeController.listStore;

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
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 20,
                  );
                },
                itemBuilder: (context, index) {
                  return StoreCard(
                    storie: stories[index],
                    press: () {
                      Get.toNamed('/detailshop', arguments: stories[index]);
                    },
                  );
                },
              ),
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
    final CategoryController categoryController = Get.put(CategoryController());

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          "Danh mục",
          style: AppStyles.textBold.copyWith(fontSize: 22),
        ),
      ),
      Obx(() {
        List<CategoryModel> categories = categoryController.listCategory;
        return Container(
            width: double.infinity,
            height: 160,
            padding: const EdgeInsets.only(left: 20),
            child: categoryController.isLoading.value
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
                      return CategoryCard(categorie: categories[index]);
                    }));
      }),
    ]);
  }
}
