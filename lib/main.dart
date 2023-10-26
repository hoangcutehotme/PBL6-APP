import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/screens/homeScreen/detail_category.dart';
import 'package:pbl6_app/src/screens/homeScreen/detail_food.dart';
import 'package:pbl6_app/src/screens/homeScreen/detail_shop.dart';
import 'package:pbl6_app/src/screens/homeScreen/home_screen.dart';
import 'package:pbl6_app/src/screens/homeScreen/order_detail.dart';
import 'package:pbl6_app/src/screens/homeScreen/order_success.dart';
import 'package:pbl6_app/src/screens/navigation/HomeMainPage.dart';
import 'package:pbl6_app/src/screens/searchScreen/search_screen.dart';
import 'package:pbl6_app/src/screens/signUpScreens/fill_info.dart';
import 'package:pbl6_app/src/screens/signUpScreens/forgot_password.dart';
import 'package:pbl6_app/src/screens/signUpScreens/sign_in_screen.dart';
import 'package:pbl6_app/src/values/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/screens/signUpScreens/sign_up_screen.dart';
import 'src/screens/signUpScreens/verify_otp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('vi', 'VN'),
        child: const MyApp()),
  );

}

_init() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.testMode = true;
  final token = prefs.getString('token');
  if (token != null) {
    print('Token: $token');
    Get.offAllNamed("/home");
  } else {
    Get.offAllNamed('/');
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      title: 'FoodDelivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: AppFonts.poppins),

      // unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SignInScreen()),
        // GetPage(name: '/', page: () => const Verify1()),
        GetPage(name: '/signin', page: () => const SignInScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/fillinfo', page: () => const FillInfoUserScreen()),
        GetPage(name: '/verifyotp', page: () => const VerifyOTPScreen()),
        GetPage(name: '/forgetpassword', page: () => const ForgetPassword()),
        GetPage(
          name: '/detailcategory',
          page: () => const DetailCategory(),
          transition: Transition.native,
        ),
        GetPage(name: '/detailshop', page: () => const DetailShop()),

        GetPage(name: '/homePage', page: () => const HomeScreen()),
        GetPage(name: '/home', page: () => const HomeMainPage()),

        GetPage(name: '/detailfood', page: () => const DetailFood()),
        GetPage(name: '/detailorder', page: () => const OrderDetail()),
        GetPage(name: '/ordersuccess', page: () => const OrderSuccess()),

        GetPage(name: '/search', page: () => const SearchScreen()),
      ],
    );
  }
}
