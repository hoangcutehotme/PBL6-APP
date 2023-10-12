import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/comment_model.dart';
import 'package:pbl6_app/src/model/food_model.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/image_button.dart';

import '../../values/app_assets.dart';
import '../../values/app_colors.dart';
import '../../widgets/star_choose.dart';

class DetailFood extends StatefulWidget {
  const DetailFood({super.key});

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  final ScrollController _scrollController = ScrollController();

  List<FoodModel> foods = [];
  List<CommentModel> comments = [];
  FoodModel? food;
  bool showTitle = false;

  @override
  void initState() {
    foods = FoodModel.getFoods();
    comments = CommentModel.getListComment();
    food = foods[4];

    _scrollController.addListener(() {
      if (_scrollController.offset >= 145) {
        setState(() {
          showTitle = true;
        });
      } else {
        setState(() {
          showTitle = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          _FlexibleHeadBar(
            showTitle: showTitle,
            food: food!,
          ),
          _InfoShop(food),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Bình luận",
                    style: AppStyles.textMedium.copyWith(
                        color: AppColors.borderGray,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: Divider(
                    color:
                        AppColors.borderGray, // specify the color of the line
                    height: 4, // specify the height of the line
                    thickness: 1, // specify the thickness of the line
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.getImg("avartar_user.png", "images"),
                            width: 40,
                            height: 40,
                            color: AppColors.mainColor1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    comments[index].username,
                                    style: AppStyles.textMedium
                                        .copyWith(color: AppColors.grayBold),
                                  ),
                                  StarChoose(rate: comments[index].rating),
                                  Text(
                                    comments[index].comment,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Divider(
                        color: AppColors
                            .borderGray, // specify the color of the line
                        height: 4, // specify the height of the line
                        thickness: 1, // specify the thickness of the line
                      ),
                    )
                  ],
                );
              },
              childCount:
                  comments.length, // Set the number of items in your list
            ),
          ),
        ],
      ),
    );
  }
}

class StarChoose extends StatelessWidget {
  const StarChoose({
    super.key,
    required this.rate,
  });

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          i < rate
              ? const Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              : const Icon(
                  Icons.star_border_purple500_outlined,
                  color: Colors.amber,
                )
      ],
    );
  }
}

class _FlexibleHeadBar extends StatelessWidget {
  const _FlexibleHeadBar({
    required this.showTitle,
    required this.food,
  });

  final bool showTitle;
  final FoodModel food;

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
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          bottom: 5,
          left: 50,
        ),
        background: Opacity(
          opacity: 1,
          child: Image.asset(
            food.imageFood,
            fit: BoxFit.fill,
          ),
        ),
      ), // Set the height of the app bar when it is expanded
    );
  }
}

SliverToBoxAdapter _InfoShop(FoodModel? food) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(food!.name, style: AppStyles.textBold.copyWith(fontSize: 20)),
          Container(
            height: 20,
          ),
          Text(
            "52 đã bán",
            style: AppStyles.textMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.borderGray),
          ),
          Container(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "${food.price.toInt()}đ",
                style: AppStyles.textMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor1),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                    child: ImageButton(
                      image: AppAssets.getImg("minus.png", "icons"),
                      press: () {},
                    ),
                  ),
                  Text(1.toString()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                    child: ImageButton(
                        image: AppAssets.getImg("plus.png", "icons"),
                        press: () {}),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
