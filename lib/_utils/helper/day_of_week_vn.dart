class DayOfWeekVN {
  static String get(int dayOfWeek) {
    switch (dayOfWeek) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        return 'Thứ ${dayOfWeek + 2}';

      default:
        return 'Chủ nhật';
    }
  }
}
