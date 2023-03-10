import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_hello_world/CountRepository.dart';
import 'package:simple_hello_world/screens/screen_1/Screen1.dart';
import 'package:simple_hello_world/screens/screen_1/Screen1Vm.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FakeCountRepo countRepo;

  Future<void> setUpScreen(WidgetTester tester) async {
    countRepo = FakeCountRepo();

    var screen1Vm = Screen1Vm(countRepo);
    var screen = Screen1(screen1Vm);

    runApp(MaterialApp(home: screen));
    await tester.pumpAndSettle();
  }

  testWidgets("rebuildsWidgetsOnNewValue", (WidgetTester tester) async {
    await setUpScreen(tester);

    expect(find.text("Screen 1"), findsOneWidget);
    expect(find.text("10"), findsOneWidget);

    await countRepo.saveCount(1002);
    await tester.pumpAndSettle();

    expect(find.text("1002"), findsOneWidget);
  });

  testWidgets("incrementsCountOnTap", (WidgetTester tester) async {
    await setUpScreen(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await expectLater(find.text("1"), findsOneWidget);
  });
}

class FakeCountRepo extends CountRepository {
  var count = 0;
  final streamController = StreamController<int>();

  @override
  Stream<int> get countSteam => streamController.stream;

  @override
  Future<int> getCount() {
    return Future.value(count);
  }

  @override
  Future<void> saveCount(int count) async {
    this.count = count;
    streamController.add(count);
  }
}
