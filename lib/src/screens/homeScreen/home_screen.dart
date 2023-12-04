import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/CategoryControler/category_controller.dart';
import 'package:pbl6_app/src/controller/ProductController/product_good_deal.dart';
import 'package:pbl6_app/src/controller/StoreController/store_controller.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/model/food_category_model.dart';
import 'package:pbl6_app/src/screens/searchScreen/seach_section.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import '../../model/store_model.dart';
import '../../values/app_colors.dart';
import '../../widgets/category_card.dart';
import '../../widgets/food_card.dart';
import '../../widgets/skelton.dart';
import '../../widgets/store_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController(respo: Get.find()), permanent: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainColorBackground,
            shadowColor: Colors.transparent,
            pinned: true,
            collapsedHeight: 120,
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
            height: 170,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: categoryController.isLoading.value
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Skelton(
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Skelton(
                            width: 100,
                          )
                        ],
                      );
                    })
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

  Column _foodSection() {
    ProductGoodDeal goodDeal = Get.put(ProductGoodDeal());
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
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: GetBuilder<ProductGoodDeal>(builder: (_) {
              if (goodDeal.isLoading.value && goodDeal.productList.isEmpty) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Skelton(
                          width: 160,
                          height: 140,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Skelton(
                          width: 140,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Skelton(
                            width: 140,
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                var productList = goodDeal.productList;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return FoodCard(food: productList[index]);
                  },
                );
              }
            }))
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
            width: double.infinity,
            height: 260,
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Obx(
              () => storeController.isLoading.value
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skelton(
                              width: 240,
                              height: 160,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Skelton(
                              width: 190,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Skelton(
                              width: 190,
                            )
                          ],
                        );
                      },
                    )
                  : ListView.separated(
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
                            Get.toNamed('/detailshop',
                                arguments: stories[index].id);
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
        // onTap: () {
        //   showSearch(context: context, delegate: SearchSection());
        // },
        child: Container(
          width: size.width,
          height: 45,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.placeholder,
          ),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(width: 2, color: AppColors.borderGray)),
          child: TextField(
            onTap: () {
              showSearch(context: context, delegate: SearchSection());
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
    var controller = Get.find<UserController>();
    // var user = controller.
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.mainColor1,
                ),
                const SizedBox(
                  width: 10,
                ),
                GetBuilder<UserController>(builder: (_) {
                  if (controller.contacChoose.address == null) {
                    return const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ));
                  } else {
                    return Flexible(
                      child: Text(
                        controller.contacChoose.address.toString(),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    );
                  }
                }),
              ],
            ),
            onTap: () {
              Get.toNamed('/changeaddress');
            },
          ),
        ),
      ],
    );
  }
}
