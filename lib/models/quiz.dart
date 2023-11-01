class Quiz {
  final int id;
  DateTime date;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final int solution;
  int? answer;

  Quiz({
    required this.id,
    required this.date,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.solution,
    this.answer,
  });

  void setDate(DateTime newDate) {
    date = newDate;
  }

  void setAnswer(int? newAnswer) {
    answer = newAnswer;
  }

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
