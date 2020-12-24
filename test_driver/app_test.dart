// Imports the Flutter Driver API.
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Generic Test App - #', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final nameFinder = find.byValueKey('nameText');
    final surnameFinder = find.byValueKey('surnameText');
    final sendFinder = find.byValueKey("sendButton");

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Field Validation - Name', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      await driver.tap(nameFinder);
      await driver.enterText("João");
      await driver.runUnsynchronized(() async {
        await driver.tap(sendFinder);
      });
      final snackbarFinder = find.text("Escreva alguma coisa aqui!");
      expect(
          await driver.getText(snackbarFinder), "Escreva alguma coisa aqui!");
    });

    test('Happy Path', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      await driver.tap(nameFinder);
      await driver.enterText("João");
      await driver.tap(surnameFinder);
      await driver.enterText("João");
      await driver.runUnsynchronized(() async {
        await driver.tap(sendFinder);
      });
      final snackbarFinder = find.text("Processando os Dados");
      expect(await driver.getText(snackbarFinder), "Processando os Dados");
    });
  });
}
