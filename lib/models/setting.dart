class Setting {
  final bool categorySport;
  final bool categoryNutrition;
  final String userName;
  final DateTime userDateOfBirth;
  final String userGender;
  final bool readAGB;
  final bool readDSGVO;

  Setting({
    required this.categorySport,
    required this.categoryNutrition,
    required this.userName,
    required this.userDateOfBirth,
    required this.userGender,
    required this.readAGB,
    required this.readDSGVO,
  });

  Map<String, dynamic> toMap() {
    return {
      'categorySport': categorySport ? 1 : 0,
      'categoryNutrition': categoryNutrition ? 1 : 0,
      'userName': userName,
      'userDateOfBirth': userDateOfBirth.toIso8601String(),
      'userGender': userGender,
      'readAGB': readAGB ? 1 : 0,
      'readDSGVO': readDSGVO ? 1 : 0,
    };
  }
}
