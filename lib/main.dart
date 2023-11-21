import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/splash_screen.dart';
import 'package:pbl6_app/src/helper/dependencies.dart' as dep;
import 'package:pbl6_app/src/screens/homeScreen/detail_category.dart';
import 'package:pbl6_app/src/screens/homeScreen/detail_food.dart';
import 'package:pbl6_app/src/screens/homeScreen/detail_shop1.dart';
import 'package:pbl6_app/src/screens/homeScreen/home_screen.dart';
import 'package:pbl6_app/src/screens/homeScreen/order_detail.dart';
import 'package:pbl6_app/src/screens/homeScreen/order_success.dart';
import 'package:pbl6_app/src/screens/navigation/HomeMainPage.dart';
import 'package:pbl6_app/src/screens/searchScreen/search_screen.dart';
import 'package:pbl6_app/src/screens/signUpScreens/fill_info.dart';
import 'package:pbl6_app/src/screens/signUpScreens/forgot_password.dart';
import 'package:pbl6_app/src/screens/signUpScreens/sign_in_screen.dart';
import 'package:pbl6_app/src/screens/userScreen/change_address_user.dart';
import 'package:pbl6_app/src/screens/userScreen/change_contact.dart';
import 'package:pbl6_app/src/screens/warningScreen/error_screen.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_fonts.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'src/screens/signUpScreens/sign_up_screen.dart';
import 'src/screens/signUpScreens/verify_otp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Dependencies <<<<<<<<<<<<<");
  await dep.init();

  ErrorWidget.builder = (details) {
    bool inBug = false;
    return Container(
      color: AppColors.placeholder,
      alignment: Alignment.center,
      child: Text(
        'Error\n${details.exception}',
        style: AppStyles.textMedium,
      ),
    );
  };

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

      unknownRoute:
          GetPage(name: '/errorscreen', page: () => const ErrorScreen()),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
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
        GetPage(name: '/detailshop', page: () => const DetailShop1()),
        GetPage(name: '/homePage', page: () => const HomeScreen()),
        GetPage(name: '/home', page: () => const HomeMainPage()),
        GetPage(name: '/detailfood', page: () => const DetailFood()),
        GetPage(name: '/detailorder', page: () => const OrderDetail()),
        GetPage(name: '/ordersuccess', page: () => const OrderSuccess()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        // GetPage(name: '/search', page: () =>  SearchSection()),
        GetPage(name: '/changeaddress', page: () => const ChangAddressUser()),
        GetPage(
            name: '/changecontact', page: () => const ChangeContactScreen()),
        GetPage(name: '/errorscreen', page: () => const ErrorScreen()),
      ],
    );
  }
}
