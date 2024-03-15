class AllEnglishExercise {
  List<EnglishExercise>? data;

  // AllEnglishExercise({this.data});
  AllEnglishExercise({List<EnglishExercise>? data}) : data = data ?? [];


  factory AllEnglishExercise.fromJson(Map<String, dynamic> json) {
    return AllEnglishExercise(
      data: (json["data"] as List<dynamic>).map((exerciseJson) {
        return EnglishExercise.fromJson(exerciseJson);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}



class EnglishExercise {
  String? exerciseTitle;      // tiêu đề
  String? exerciseDescription;    // nội dung câu hỏi
  List<String>? answerHints;      // những câu trả lời gợi ý
  String? formulaLink;          // link đến tài liệu
  List<String>? options;      // đáp án
  String? correctAnswer;    // câu trả lời đúng
  bool? isCorrect = true;             // đáp án đúg or sai
  String? answerYourChoose = 'null';             // đáp án ng dùng chọn
  bool? isChangeStateAnswer = false;             // có thay đổi color answer ko

  EnglishExercise({
    this.exerciseTitle,
    this.exerciseDescription,
    this.answerHints,
    this.formulaLink,
    this.options,
    this.correctAnswer,
  });

  factory EnglishExercise.fromJson(Map<String, dynamic> json) {
    return EnglishExercise(
      exerciseTitle: json['exerciseTitle'],
      exerciseDescription: json['exerciseDescription'],
      answerHints: List<String>.from(json['answerHints']),
      formulaLink: json['formulaLink'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseTitle': exerciseTitle,
      'exerciseDescription': exerciseDescription,
      'answerHints': answerHints,
      'formulaLink': formulaLink,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }
}