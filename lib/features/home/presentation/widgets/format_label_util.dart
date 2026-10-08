String formatLabel({
  required String label,
  required int index,
  required String period,
}) {
  switch (period) {
    case 'day':
      // 04:00 -> 04
      return label.split(':').first;

    case 'month':
      // Dec 21
      final parts = label.split(' ');
      if (parts.length == 2) {
        // faqat birinchi elementda oy nomi chiqadi
        return index == 0 ? label : parts[1];
      }
      return label;

    case 'week':
    case 'year':
    default:
      return label;
  }
}
