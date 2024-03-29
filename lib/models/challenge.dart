class Challenge {
  final int id;
  DateTime date;
  final String title;
  final String description;
  final String explanation;
  final String category;
  final Map<int, String> progress;
  int userProgress;

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

  void setDate(DateTime newDate) {
    date = newDate;
  }

  void setUserProgress(int progress) {
    userProgress = progress;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'explanation': explanation,
      'category': category,
      'progress': progressMapToString(progress),
      'userProgress': userProgress,
    };
  }

  static Map<int, String> stringToProgressMap(String progress) {
    Map<int, String> result = {};
    if (progress.isNotEmpty) {
      progress = progress.substring(1, progress.length - 1);
      List<String> pairs = progress.split(', ');
      for (var pair in pairs) {
        List<String> keyValue = pair.split(': ');
        result[int.parse(keyValue[0])] = keyValue[1].replaceAll('"', '');
      }
    }
    return result;
  }

  static String progressMapToString(Map<int, String> progress) {
    String result = '{';
    progress.forEach((key, value) {
      result += '$key: $value, ';
    });
    result = result.substring(0, result.length - 2);
    result += '}';
    return result;
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      id: map['id'],
      date: DateTime.parse(map['date']),
      title: map['title'],
      description: map['description'],
      explanation: map['explanation'],
      category: map['category'],
      progress: stringToProgressMap(map['progress']),
      userProgress: map['userProgress'],
    );
  }
}
