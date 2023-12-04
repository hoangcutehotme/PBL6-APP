import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// import app to test
import 'package:pbl6_app/main.dart' as app;
import 'package:pbl6_app/src/screens/signUpScreens/sign_in_screen.dart';
import 'package:pbl6_app/src/screens/userScreen/change_user_info.dart';

void main() {

  group('update info user', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('update success ', (tester) async {
      app.main();
      await tester.pumpWidget(const SignInScreen());
      // wait until the app pump and settle
      await tester.pumpAndSettle();
      // finder for element

      final emailInput = find.byKey(const Key('email'));
      final passwordInput = find.byKey(const Key('password'));
      final login = find.byKey(const Key('login'));

      //
      await tester.enterText(emailInput, "hoangnt131102@gmail.com");
      await tester.enterText(passwordInput, "hoangpro");
      await tester.pumpAndSettle();

      // Perform the login action
      await tester.tap(login);
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('user'));
      await tester.pumpAndSettle();

      final lastname = find.byKey(const Key('lastname'));
      final firstname = find.byKey(const Key('firstname'));
      final phone = find.byKey(const Key('phone'));
      final address = find.byKey(const Key('address'));

      // Check if the UserScreen is displayed after tapping
      await tester.tap(find.byKey(const Key('changeUserButton')));
      await tester.pumpAndSettle();

      await tester.enterText(lastname, 'Nguyễn');
      await tester.enterText(firstname, 'Trọng Hoàng');

      // await tester.enterText(firstname, 'Hoàng');
      await tester.enterText(phone, '0988898541');
      await tester.enterText(address, '53, Nguyễn Lương Bằng, Đà Nẵng');

      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ok'));
      await tester.pumpAndSettle();
    });

    testWidgets('update fail - address empty ', (tester) async {
      app.main();
      await tester.pumpWidget(const ChangeUserInfo());

      // wait until the app pump and settle
      await tester.pumpAndSettle();

      await tester
          .tap(find.byTooltip('user')); // Locate the bottom navigation bar
      await tester.pumpAndSettle(); // Rebuild the widget after the tap

      // Check if the UserScreen is displayed after tapping
      await tester.tap(find.byKey(const Key('changeUserButton')));
      await tester.pumpAndSettle();

      // change user info
      final lastname = find.byKey(const Key('lastname'));
      final firstname = find.byKey(const Key('firstname'));
      final phone = find.byKey(const Key('phone'));
      final address = find.byKey(const Key('address'));

      await tester.enterText(lastname, 'Nguyễn Trần');

      await tester.enterText(firstname, 'Hoàn');

      await tester.enterText(phone, '0988898543');

      await tester.enterText(address, '');

      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pumpAndSettle();

      // await tester.tap(find.text('Ok'));
      // await tester.pumpAndSettle();

      // expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('update fail - lastname empty ', (tester) async {
      app.main();
      await tester.pumpWidget(const ChangeUserInfo());

      // wait until the app pump and settle
      await tester.pumpAndSettle();

      await tester
          .tap(find.byTooltip('user')); // Locate the bottom navigation bar
      await tester.pumpAndSettle(); // Rebuild the widget after the tap

      // Check if the UserScreen is displayed after tapping
      await tester.tap(find.byKey(const Key('changeUserButton')));
      await tester.pumpAndSettle();

      // change user info
      final lastname = find.byKey(const Key('lastname'));
      final firstname = find.byKey(const Key('firstname'));
      final phone = find.byKey(const Key('phone'));
      final address = find.byKey(const Key('address'));

      await tester.enterText(lastname, '');

      await tester.enterText(firstname, 'Hoàn');

      await tester.enterText(phone, '0988898543');

      await tester.enterText(address, '54, Nguyễn Lương Bằng, Đà Nẵng');

      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pumpAndSettle();

      // await tester.tap(find.text('Ok'));
      // await tester.pumpAndSettle();

      // expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('update fail - phonenumber is wrong ', (tester) async {
      app.main();
      await tester.pumpWidget(const ChangeUserInfo());

      // wait until the app pump and settle
      await tester.pumpAndSettle();

      await tester
          .tap(find.byTooltip('user')); // Locate the bottom navigation bar
      await tester.pumpAndSettle(); // Rebuild the widget after the tap

      // Check if the UserScreen is displayed after tapping
      await tester.tap(find.byKey(const Key('changeUserButton')));
      await tester.pumpAndSettle();

      // change user info
      final lastname = find.byKey(const Key('lastname'));
      final firstname = find.byKey(const Key('firstname'));
      final phone = find.byKey(const Key('phone'));
      final address = find.byKey(const Key('address'));

      await tester.enterText(lastname, 'Nguyên');

      await tester.enterText(firstname, 'Hoàn');

      await tester.enterText(phone, '0988ab1234');

      await tester.enterText(address, '54, Nguyễn Lương Bằng, Đà Nẵng');

      await Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('saveButton')));

      await tester.pumpAndSettle();

      // await tester.tap(find.text('Ok'));
      // await tester.pumpAndSettle();

      // expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('update fail - phonenumber is not  ', (tester) async {
      app.main();
      await tester.pumpWidget(const ChangeUserInfo());

      // wait until the app pump and settle
      await tester.pumpAndSettle();

      await tester
          .tap(find.byTooltip('user')); // Locate the bottom navigation bar
      await tester.pumpAndSettle(); // Rebuild the widget after the tap

      // Check if the UserScreen is displayed after tapping
      await tester.tap(find.byKey(const Key('changeUserButton')));
      await tester.pumpAndSettle();

      // change user info
      final lastname = find.byKey(const Key('lastname'));
      final firstname = find.byKey(const Key('firstname'));
      final phone = find.byKey(const Key('phone'));
      final address = find.byKey(const Key('address'));

      await tester.enterText(lastname, 'Nguyên');

      await tester.enterText(firstname, 'Hoàn');

      await tester.enterText(phone, '0988ab1234');

      await tester.enterText(address, '54, Nguyễn Lương Bằng, Đà Nẵng');

      await Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('saveButton')));

      await tester.pumpAndSettle();

      // await tester.tap(find.text('Ok'));
      // await tester.pumpAndSettle();

      // expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('update fail - firstname empty ', (tester) async {
      app.main();
      await tester.pumpWidget(const ChangeUserInfo());

      // wait until the app pump and settle
      await tester.pumpAndSettle();

      await tester
          .tap(find.byTooltip('user')); // Locate the bottom navigation bar
      await tester.pumpAndSettle(); // Rebuild the widget after the tap

      // Check if the UserScreen is displayed after tapping
      await tester.tap(find.byKey(const Key('changeUserButton')));
      await tester.pumpAndSettle();

      // change user info
      final lastname = find.byKey(const Key('lastname'));
      final firstname = find.byKey(const Key('firstname'));
      final phone = find.byKey(const Key('phone'));
      final address = find.byKey(const Key('address'));

      await tester.enterText(lastname, 'Nguyễn');

      await tester.enterText(firstname, '');

      await tester.enterText(phone, '0988898543');

      await tester.enterText(address, '54, Nguyễn Lương Bằng, Đà Nẵng');

      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pumpAndSettle();
    });
  });
}
