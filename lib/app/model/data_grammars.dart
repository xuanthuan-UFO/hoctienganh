class DataGrammars {
  String? nameFile ;
  String? deceptionVi;
  String? deceptionEn;
  String? idPractice;

  DataGrammars({this.nameFile, this.deceptionVi, this.deceptionEn, this.idPractice});

  factory DataGrammars.fromJson(Map<String, dynamic> json) => DataGrammars(
    nameFile: json["nameFile"],
    deceptionVi: json["deceptionVi"],
    deceptionEn: json["deceptionEn"],
    idPractice: json["idPractice"],
  );

  Map<String, dynamic> toJson() => {
    "nameFile": nameFile,
    "deceptionVi": deceptionVi,
    "deceptionEn": deceptionEn,
    "idPractice": idPractice,
  };
}