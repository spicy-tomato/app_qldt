class ScoreModel {
  final String semester;
  final String moduleName;
  final int credit;
  final String evaluation;
  final double processScore;
  final double testScore;
  final double theoreticalScore;

  ScoreModel({
    required this.semester,
    required this.moduleName,
    required this.credit,
    required this.evaluation,
    required this.processScore,
    required this.testScore,
    required this.theoreticalScore,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      moduleName: json['Module_Name'],
      semester: json['Semester'],
      credit: json['Credit'],
      evaluation: json['Evaluation'],
      processScore: json['Process_Score'].toDouble(),
      testScore: json['Test_Score'].toDouble(),
      theoreticalScore: json['Theoretical_Score'].toDouble(),
    );
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      moduleName: map['module_name'],
      semester: map['semester'],
      credit: map['credit'],
      evaluation: map['evaluation'],
      processScore: map['process_score'],
      testScore: map['test_score'],
      theoreticalScore: map['theoretical_score'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'module_name': moduleName,
      'semester': semester,
      'credit': credit,
      'evaluation': evaluation,
      'process_score': processScore,
      'test_score': testScore,
      'theoretical_score': theoreticalScore,
    };
  }

  List<dynamic> toList() {
    return [
      processScore,
      testScore,
      theoreticalScore,
      credit,
      semester,
      evaluation,
    ];
  }

  @override
  String toString() {
    return moduleName;
  }
}