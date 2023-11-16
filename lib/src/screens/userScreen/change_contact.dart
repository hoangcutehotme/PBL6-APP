import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/change_contact_user.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
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
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  TextFieldContainer(
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
                  TextFieldContainer(
                    label: "Địa chỉ",
                    child: TextField(
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

                  
                ],
              ),
            );
          }),
    );
  }
}
