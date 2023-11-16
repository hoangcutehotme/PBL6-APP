import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/model/contact_model.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';

class ListContactScreen extends StatelessWidget {
  const ListContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.placeholder,
      appBar: AppWidget.appBar("Thông tin liên hệ"),
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
                    onTap: () {
                      Get.toNamed('/changecontact', arguments: Contact());
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
