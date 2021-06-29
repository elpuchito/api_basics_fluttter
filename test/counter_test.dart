import 'package:test/test.dart';
import 'package:api_basics/counter.dart';

//unit_testing
void main() {
  // test('testing if the counter method increments', () {
  //   final counter = new Counter();
  //   counter.increment();
  //   expect(counter.value, 1);
  // });

  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
