import 'package:flutter_test/flutter_test.dart';
import 'package:dangshi/core/utils/date_utils.dart';

void main() {
  group('calculateTimeOffset', () {
    // Edge case: same day (0 days)
    test('returns "0天后" when dates are the same', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 1);
      expect(calculateTimeOffset(from, to), '0天后');
    });

    test('returns "0天后" when to date is before from date', () {
      final from = DateTime(2024, 1, 2);
      final to = DateTime(2024, 1, 1);
      expect(calculateTimeOffset(from, to), '0天后');
    });

    // Days range: 1-6 days → "X天后"
    test('returns "1天后" for 1 day difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 2);
      expect(calculateTimeOffset(from, to), '1天后');
    });

    test('returns "6天后" for 6 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 7);
      expect(calculateTimeOffset(from, to), '6天后');
    });

    // Week range: 7-13 days → "1周后"
    test('returns "1周后" for 7 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 8);
      expect(calculateTimeOffset(from, to), '1周后');
    });

    test('returns "1周后" for 13 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 14);
      expect(calculateTimeOffset(from, to), '1周后');
    });

    // Week range: 14-20 days → "2周后"
    test('returns "2周后" for 14 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 15);
      expect(calculateTimeOffset(from, to), '2周后');
    });

    test('returns "2周后" for 20 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 21);
      expect(calculateTimeOffset(from, to), '2周后');
    });

    // Week range: 21-29 days → "3周后"
    test('returns "3周后" for 21 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 22);
      expect(calculateTimeOffset(from, to), '3周后');
    });

    test('returns "3周后" for 29 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 30);
      expect(calculateTimeOffset(from, to), '3周后');
    });

    // Month range: 30-59 days → "1个月后"
    test('returns "1个月后" for 30 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 31);
      expect(calculateTimeOffset(from, to), '1个月后');
    });

    test('returns "1个月后" for 59 days difference', () {
      final from = DateTime(2024, 1, 2);
      final to = DateTime(2024, 3, 1);
      expect(calculateTimeOffset(from, to), '1个月后');
    });

    // Month range: 60-89 days → "2个月后"
    test('returns "2个月后" for 60 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 3, 1);
      expect(calculateTimeOffset(from, to), '2个月后');
    });

    test('returns "2个月后" for 89 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 3, 30);
      expect(calculateTimeOffset(from, to), '2个月后');
    });

    // Month range: 90-179 days → "3个月后"
    test('returns "3个月后" for 90 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 4, 1);
      expect(calculateTimeOffset(from, to), '3个月后');
    });

    test('returns "3个月后" for 179 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 6, 28);
      expect(calculateTimeOffset(from, to), '3个月后');
    });

    // Month range: 180-364 days → "X个月后" (rounded up)
    test('returns "6个月后" for 180 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 6, 29);
      expect(calculateTimeOffset(from, to), '6个月后');
    });

    test('returns "9个月后" for 270 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 9, 27);
      expect(calculateTimeOffset(from, to), '9个月后');
    });

    test('returns "12个月后" for 360 days difference (exactly 12 months)', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 12, 26); // 360 days in 2024 (leap year)
      expect(calculateTimeOffset(from, to), '12个月后');
    });

    // Year range: 365+ days → "1年后"
    test('returns "1年后" for 365 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2025, 1, 1);
      expect(calculateTimeOffset(from, to), '1年后');
    });

    test('returns "1年后" for 730 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2026, 1, 1);
      expect(calculateTimeOffset(from, to), '1年后');
    });

    test('returns "1年后" for 1000 days difference', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2026, 9, 28);
      expect(calculateTimeOffset(from, to), '1年后');
    });

    // Additional edge cases
    test('handles leap year correctly', () {
      final from = DateTime(2024, 2, 28);
      final to = DateTime(2024, 3, 1); // 2 days in leap year
      expect(calculateTimeOffset(from, to), '2天后');
    });

    test('handles year transition', () {
      final from = DateTime(2024, 12, 30);
      final to = DateTime(2025, 1, 5); // 6 days
      expect(calculateTimeOffset(from, to), '6天后');
    });
  });
}
