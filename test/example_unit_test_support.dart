import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';

Future<void> Function() harness(
    UnitTestHarnessCallback<ExampleUnitTestHarness> callback) {
  return () => givenWhenThenUnitTest(ExampleUnitTestHarness(), callback);
}

class ExampleUnitTestHarness {
  ExampleUnitTestHarness() : super();

  int counter = 0;
}

extension ExampleGiven on UnitTestGiven<ExampleUnitTestHarness> {
  void preCondition() {
    this.harness.counter = 1;
  }
}

extension ExampleWhen on UnitTestWhen<ExampleUnitTestHarness> {
  Future<void> userPerformsSomeAction() async {
    this.harness.counter++;
  }
}

extension ExampleThen on UnitTestThen<ExampleUnitTestHarness> {
  void makeSomeAssertion() {
    expect(this.harness.counter, equals(2));
  }
}
