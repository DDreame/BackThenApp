/// Date utility functions for the Dangshi app.

/// Calculates the time offset between two dates and returns a human-readable string.
///
/// [from] is the starting date
/// [to] is the ending date
///
/// Returns strings like:
/// - "X天后" for 1-6 days
/// - "1周后" for 7-13 days
/// - "2周后" for 14-20 days
/// - "3周后" for 21-29 days
/// - "1个月后" for 30-59 days
/// - "2个月后" for 60-89 days
/// - "3个月后" for 90-179 days
/// - "X个月后" for 180-364 days (rounded up months)
/// - "1年后" for 365+ days
String calculateTimeOffset(DateTime from, DateTime to) {
  final days = to.difference(from).inDays;

  if (days <= 0) {
    return '0天后';
  }

  if (days >= 365) {
    return '1年后';
  }

  if (days >= 180) {
    // 180-364 days: calculate months rounded up
    final months = (days / 30).ceil();
    return '${months}个月后';
  }

  if (days >= 90) {
    return '3个月后';
  }

  if (days >= 60) {
    return '2个月后';
  }

  if (days >= 30) {
    return '1个月后';
  }

  if (days >= 21) {
    return '3周后';
  }

  if (days >= 14) {
    return '2周后';
  }

  if (days >= 7) {
    return '1周后';
  }

  return '$days天后';
}