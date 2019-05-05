
class DurationUiModel {
  final String title;
  final int duration;

  DurationUiModel(this.title, this.duration);

  static final List<DurationUiModel> all = [
    DurationUiModel('30 seconds', 30),
    DurationUiModel('60 seconds', 60),
    DurationUiModel('90 seconds', 90),
  ];
}
