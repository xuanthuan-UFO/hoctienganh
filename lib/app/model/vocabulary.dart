class Vocabulary {
  List<Topic>? topic;

  Vocabulary({
    this.topic,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    List<Topic> topics = List<Topic>.from(json['topic'].map((x) => Topic.fromJson(x)));
    return Vocabulary(
      topic: topics,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
    };
  }
}

class Topic {
  String topicName;
  List<DetailWord> data;

  Topic({
    required this.topicName,
    required this.data,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    List<DetailWord> detailWords = List<DetailWord>.from(json['data'].map((x) => DetailWord.fromJson(x)));
    return Topic(
      topicName: json['topicName'],
      data: detailWords,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topicName': topicName,
      'data': data.map((detailWord) => detailWord.toJson()).toList(),
    };
  }
}

class DetailWord{
  String? word;
  String? pronunciation;
  String? type;
  String? definition;

  DetailWord({
    this.word,
    this.pronunciation,
    this.type,
    this.definition,
  });

  factory DetailWord.fromJson(Map<String, dynamic> json) {
    return DetailWord(
      word: json['word'],
      pronunciation: json['pronunciation'],
      type: json['type'],
      definition: json['definition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'pronunciation': pronunciation,
      'type': type,
      'definition': definition,
    };
  }
}