
class ChallengeCategory {
  final List<String> challenges;

  ChallengeCategory({required this.challenges});

  factory ChallengeCategory.fromJson(Map<String, dynamic> json) {
    return ChallengeCategory(
      challenges: List<String>.from(json['challenges']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'challenges': challenges,
    };
  }
}

// Define the ChallengesData class
class ChallengesData {
  final Map<String, ChallengeCategory> categories;

  ChallengesData({required this.categories});

  factory ChallengesData.fromJson(Map<String, dynamic> json) {
    return ChallengesData(
      categories: json.map((key, value) => MapEntry(
            key,
            ChallengeCategory.fromJson(value),
          )),
    );
  }

  Map<String, dynamic> toJson() {
    return categories.map((key, value) => MapEntry(
          key,
          value.toJson(),
        ));
  }
}
