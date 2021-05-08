class Score {
  final String semester;
  final String moduleName;
  final int credit;
  final String evaluation;
  final double processScore;
  final double testScore;
  final double theoreticalScore;

  Score({
    required this.semester,
    required this.moduleName,
    required this.credit,
    required this.evaluation,
    required this.processScore,
    required this.testScore,
    required this.theoreticalScore,
  });

  factory Score.fromJson(Map<String, dynamic> json){
    return Score(
        semester: json['Semester'],
        moduleName: json['Module_Name'],
        credit: json['Credit'],
        evaluation: json['Evaluation'],
        processScore: json['Process_Score'],
        testScore: json['Test_Score'],
        theoreticalScore: json['Theoretical_Score'],
    );
  }

  factory Score.fromMap(Map<String, dynamic> map){
    return Score(
      semester: map['semester'],
      moduleName: map['module_name'],
      credit: map['credit'],
      evaluation: map['evaluation'],
      processScore: map['process_score'],
      testScore: map['test_score'],
      theoreticalScore: map['theoretical_score'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "semester": semester,
      "module_name": moduleName,
      "credit": credit,
      "evaluation": evaluation,
      "process_score": processScore,
      "test_score": testScore,
      "theoretical_score": theoreticalScore,
    };
  }
}
