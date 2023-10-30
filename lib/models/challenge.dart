class Challenge {
  final int id;
  final DateTime date;
  final String title;
  final String description;
  final String explanation;
  final String category;
  final List<List<int>> progress;
  final int userProgress;

  Challenge({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.explanation,
    required this.category,
    required this.progress,
    required this.userProgress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'explanation': explanation,
      'category': category,
      'progress': progress.toString(),
      'userProgress': userProgress,
    };
  }
}
