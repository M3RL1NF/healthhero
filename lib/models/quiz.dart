class Quiz {
  final int id;
  final DateTime date;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String solution;
  final String answer;

  Quiz({
    required this.id,
    required this.date,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.solution,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'question': question,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'solution': solution,
      'answer': answer,
    };
  }
}
