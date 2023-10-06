import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/rounded_button.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final List<String> _otpCode = ["", "", "", ""];

  bool checkVerifyOTP(List<String> otpCode, String verifyOtp) {
    String otp = otpCode.join();
    print("OTP");
    print(otp);
    if (otp != verifyOtp) {
      // check verify
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Text(
              "Xác thực OTP",
              style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Vui lòng nhập code đã gửi vào email"),
            const SizedBox(
              height: 50,
            ),
            Form(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (var i = 0; i < 4; i++)
                  Container(
                    alignment: Alignment.center,
                    width: 65,
                    height: 68,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 1, color: AppColors.borderGray)),
                    child: TextFormField(
                      onChanged: (value) {
                        _otpCode[i] = value;
                        if (value.length == 1 && i < 3) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && i > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      onSaved: (pin) {
                        _otpCode[i] = pin as String;
                        // print(_otpCode[i]);
                      },
                      style: AppStyles.textMedium.copyWith(fontSize: 20),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
              ],
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Không nhận được OTP ?",
              style: AppStyles.textMedium,
            ),
            Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Gửi lại',
                    style: AppStyles.textBold
                        .copyWith(color: AppColors.mainColor1, fontSize: 16),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: RoundedButton(
                press: () {
                  bool isVerified = checkVerifyOTP(_otpCode, "1234");
                  if (isVerified) {
                    // OTP is verified, navigate to the next screen
                    Get.toNamed("/signin");
                  } else {
                    Get.toNamed("/signin");
                  }
                  // Get.toNamed("/signin");
                },
                text: 'Xác thực',
                size: Size(size.width * 0.8, 56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
