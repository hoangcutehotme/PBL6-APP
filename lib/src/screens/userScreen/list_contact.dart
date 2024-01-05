import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/ship_info_cart.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/model/contact_model.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

import '../../values/app_styles.dart';

class ListContactScreen extends StatelessWidget {
  const ListContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.placeholder,
      appBar: AppBar(
        foregroundColor: AppColors.mainColor1,
        backgroundColor: AppColors.mainColorBackground,
        shadowColor: Colors.transparent,
        title: Text(
          "Thông tin liên hệ",
          style: AppStyles.textBold
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/changecontact', arguments: Contact());
              },
              icon: Image.asset(
                AppAssets.getImg("plus.png", "icons"),
                color: AppColors.mainColor1,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<UserController>(builder: (userController) {
          var listContacts = userController.user.value.contact;
          return ListView.separated(
              itemBuilder: (context, index) {
                var contact = listContacts[index];
                return Container(
                  decoration: ShapeDecoration(
                    color: AppColors.mainColorBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: userController.contacChoose.id == contact.id
                            ? AppColors.mainColor1
                            : Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () async {
                      // Get.toNamed('/changecontact', arguments: Contact());
                      await userController.changeAddressContactDefault(contact);
                      await Get.find<ShippingFeeController>()
                          .getCurrentContact();
                    },
                    leading: const Icon(
                      Icons.location_on,
                      color: AppColors.mainColor1,
                    ),
                    title: const Text("Địa chỉ"),
                    subtitle:
                        Text("${contact.address}\n${contact.phoneNumber}\n"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userController.contacChoose.id == contact.id
                            ? const Icon(
                                Icons.check_circle,
                                color: AppColors.mainColor1,
                              )
                            : const Icon(Icons.check_circle_outlined),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: AppColors.placeholder,
                );
              },
              itemCount: listContacts!.length);
        }),
      ),
    );
  }
}
