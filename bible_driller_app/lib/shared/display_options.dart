// lib/shared/display_options.dart

class DisplayOption {
  final String display;
  final String value;
  const DisplayOption(this.display, this.value);
}

const List<DisplayOption> versionOptions = [
  DisplayOption('KJV', 'kjv'),
  DisplayOption('CSB', 'csb'),
];

const List<DisplayOption> colorOptions = [
  DisplayOption('Red', 'red'),
  DisplayOption('Green', 'green'),
  DisplayOption('Blue', 'blue'),
];

String getDisplayValue(String value, List<DisplayOption> options) {
  return options.firstWhere(
    (opt) => opt.value == value,
    orElse: () => DisplayOption(value, value),
  ).display;
}
