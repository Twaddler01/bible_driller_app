// completion_call_model.dart
class KeyPassagesCallModel {
  final String name;
  final String ref;
  final String color;

  KeyPassagesCallModel({required this.name, required this.ref, required this.color});

  // From JSON to Dart object
  factory KeyPassagesCallModel.fromJson(Map<String, dynamic> json) {
    return KeyPassagesCallModel(
      name: json['name']?.replaceAll('&apos;', "'") ?? '',
      ref: json['ref'],
      color: json['color'],
    );
  }

  // Convert Dart object verseck to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ref': ref,
      'color': color,
    };
  }
}

/*
  {
    "name": "God&apos;s Covenant with Abraham",
    "ref": "Genesis 12:1-3",
    "color": "blue"
  },
  */