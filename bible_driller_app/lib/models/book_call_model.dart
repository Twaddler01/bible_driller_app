// book_call_model.dart
class BookCallModel {
  final String book;
  final String ba;

  BookCallModel({required this.book, required this.ba});

  // From JSON to Dart object
  factory BookCallModel.fromJson(Map<String, dynamic> json) {
    return BookCallModel(
      book: json['book'],
      ba: json['ba'],
    );
  }

  // Convert Dart object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'book': book,
      'ba': ba,
    };
  }
}
