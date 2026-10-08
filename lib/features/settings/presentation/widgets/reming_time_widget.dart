class RemainingTime {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  RemainingTime(this.days, this.hours, this.minutes, this.seconds);

  factory RemainingTime.fromDuration(Duration d) {
    return RemainingTime(
      d.inDays,
      d.inHours % 24,
      d.inMinutes % 60,
      d.inSeconds % 60,
    );
  }
}
