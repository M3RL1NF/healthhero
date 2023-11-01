class Setting {
  bool categorySport;
  bool categoryNutrition;
  String userName;
  DateTime userDateOfBirth;
  String userGender;
  bool readAGB;
  bool readDSGVO;
  final int dailyQuizzes;
  final int dailyChallenges;

  Setting({
    required this.categorySport,
    required this.categoryNutrition,
    required this.userName,
    required this.userDateOfBirth,
    required this.userGender,
    required this.readAGB,
    required this.readDSGVO,
    required this.dailyQuizzes,
    required this.dailyChallenges,
  });

  void setCategorySport(bool value) {
    categorySport = value;
  }

  void setCategoryNutrition(bool value) {
    categoryNutrition = value;
  }

  void setUserName(String name) {
    userName = name;
  }

  void setUserDateOfBirth(DateTime dob) {
    userDateOfBirth = dob;
  }

  void setUserGender(String gender) {
    userGender = gender;
  }

  void setReadAGB(bool value) {
    readAGB = value;
  }

  void setReadDSGVO(bool value) {
    readDSGVO = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'categorySport': categorySport ? 1 : 0,
      'categoryNutrition': categoryNutrition ? 1 : 0,
      'userName': userName,
      'userDateOfBirth': userDateOfBirth.toIso8601String(),
      'userGender': userGender,
      'readAGB': readAGB ? 1 : 0,
      'readDSGVO': readDSGVO ? 1 : 0,
      'dailyQuizzes': dailyQuizzes,
      'dailyChallenges': dailyChallenges,
    };
  }
}
