import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/change_contact_user.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';

import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import '../../widgets/text_field_widget.dart';

class ChangeContactScreen extends StatelessWidget {
  const ChangeContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeContact controller = Get.put(
        ChangeContact(userController: Get.find(), userRespo: Get.find()));
    var contact = Get.arguments;
    return Scaffold(
      appBar: AppWidget.appBar("Thay đổi thông tin liên hệ"),
      body: GetBuilder<ChangeContact>(
          initState: (state) => controller.initValue(contact),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: TextFieldContainer(
                    label: 'Số điện thoại',
                    child: TextField(
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.phone,
                          color: AppColors.mainColor1,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        hintText: "Số điện thoại",
                        hintStyle: AppStyles.textMedium
                            .copyWith(color: AppColors.colorTextBlur),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextFieldContainer(
                    label: "Địa chỉ",
                    child: TextField(
                      onTap: () {
                        // Get.to(() => const Home1());
                      },
                      controller: controller.addressController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.location_on,
                          color: AppColors.mainColor1,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        hintText: "Địa chỉ",
                        hintStyle: AppStyles.textMedium
                            .copyWith(color: AppColors.colorTextBlur),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor1),
                        onPressed: () {
                          if (controller.checkData()) {
                            controller.addNewContact();
                          }
                        },
                        child: const Text('Thêm'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor1),
                        onPressed: () {
                          if (controller.checkData()) {
                            controller.addNewContact();
                          }
                        },
                        child: const Text('Sửa'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor1),
                        onPressed: () {
                          if (controller.checkData()) {
                            controller.addNewContact();
                          }
                        },
                        child: const Text('Xoá'),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
