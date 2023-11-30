import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test/test.dart';

// void main() {
//   group('MyApp test', () {
//     IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//     late FlutterDriver driver;

//     // Set up the FlutterDriver before tests
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });

//     // Close the connection to the driver after tests
//     tearDownAll(() async {
//       await driver.close();
//     });

//     test('Verify success snackbar appearance', () async {
//       final emailInput = find.byValueKey(const Key('email'));
//       final passwordInput = find.byValueKey(const Key('password'));
//       final login = find.byValueKey(const Key('login'));

//       final result = find.byValueKey('result');
//       // Perform actions using the driver
//       await driver.enterText('hoangcool0988@gmail.com');
//       await driver.enterText('hoangpro12');

//       await driver.tap(login);

//       // Wait for a UI change that indicates the snackbar appeared
//       await driver.waitFor(find.text('Đăng nhập thành công'),
//           timeout: const Duration(seconds: 5));

//       expect(await driver.getText(result), 'Đăng nhập thành công');
//     });
//   });
// }
