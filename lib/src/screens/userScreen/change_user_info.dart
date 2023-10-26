import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';

import '../../values/app_colors.dart';
import '../../values/app_styles.dart';

class ChangeUserInfo extends StatefulWidget {
  const ChangeUserInfo({super.key});

  @override
  State<ChangeUserInfo> createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.mainColor1,
        backgroundColor: AppColors.mainColorBackground,
        title: Text(
          "Thay đổi thông tin",
          style: AppStyles.textBold.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      // labelText: 'Họ ',
                      label: Text('Họ'),
                    ),
                    initialValue: 'Nguyễn Trọng',
                    keyboardType: TextInputType.name,
                    // controller: userController.lastname,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tên '),
                    keyboardType: TextInputType.name,
                    // controller: userController.lastname,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email '),
                    keyboardType: TextInputType.emailAddress,
                    // controller: userController.lastname,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Số điện thoại '),
                    keyboardType: TextInputType.phone,
                    // controller: userController.lastname,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (Form.of(context).validate()) {
                        // Form is valid, process the data
                        // Update user's last name and first name using the values above
                        // Your logic to update user information goes here
                        Get.snackbar('Success', 'Profile updated successfully');
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
