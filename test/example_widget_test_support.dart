import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<ExampleWidgetTestHarness> callback) {
  return (tester) =>
      givenWhenThenWidgetTest(ExampleWidgetTestHarness(tester), callback);
}

class ExampleWidgetTestHarness extends WidgetTestHarness {
  ExampleWidgetTestHarness(super.tester);
}

extension ExampleGiven on WidgetTestGiven<ExampleWidgetTestHarness> {
  Future<void> preCondition() async {
    await tester.pumpWidget(const WidgetUnderTest());
  }
}

extension ExampleWhen on WidgetTestWhen<ExampleWidgetTestHarness> {
  Future<void> userPerformsSomeAction() async {
    await tester.tap(find.text('0'));
  }
}

extension ExampleThen on WidgetTestThen<ExampleWidgetTestHarness> {
  Future<void> makeSomeAssertion() async {
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  }
}

class WidgetUnderTest extends StatefulWidget {
  const WidgetUnderTest({super.key});

  @override
  WidgetUnderTestState createState() => WidgetUnderTestState();
}

class WidgetUnderTestState extends State<WidgetUnderTest> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _counter++;
          });
        },
        child: Text(_counter.toString()),
      ),
    );
  }
}
