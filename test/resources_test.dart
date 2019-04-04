import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Assert that', () {
    const resourcesForTest = [
      "0",
      "1",
      "rPrepare0",
      "rPrepare1",
      "rScore",
      "rWelcome",
      "rToRules",
      "rRules",
      "rAgain",
      "rReady",
      "rPlay",
      "rDone",
      "rSkip",
      "rBack",
      "words"
    ];
    dynamic data;

    setUpAll(() async {
      data = await rootBundle
        .loadString('res/data.json')
        .then((data) => json.decode(data));
    });

    for (var resourceCode in resourcesForTest) {
      // Test not working because of `rootBundle`
      // https://github.com/flutter/flutter/issues/12999
      test('resource [$resourceCode] exists in data.json', () {
        var resource = data[resourceCode];

        expect(resource, isNotEmpty);
      }, skip: true);
    }
  });
}
