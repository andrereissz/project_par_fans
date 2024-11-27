class Perfume {
  String nome;
  String marca;
  int notaCompartilhavel;
  int notaEstacao;
  int notaGeral;
  int notaOcasiao;

  Perfume({
    required this.nome,
    required this.marca,
    required this.notaCompartilhavel,
    required this.notaEstacao,
    required this.notaGeral,
    required this.notaOcasiao,
  });

  Perfume.fromJson(Map<String, Object?> json)
      : this(
          nome: json['nome']! as String,
          marca: json['marca']! as String,
          notaCompartilhavel: json['notaCompartilhavel']! as int,
          notaEstacao: json['notaEstacao']! as int,
          notaGeral: json['notaGeral']! as int,
          notaOcasiao: json['notaOcasiao']! as int,
        );

  Perfume copyWith({
    String? nome,
    String? marca,
    int? notaCompartilhavel,
    int? notaEstacao,
    int? notaGeral,
    int? notaOcasiao,
  }) {
    return Perfume(
        nome: nome ?? this.nome,
        marca: marca ?? this.marca,
        notaCompartilhavel: notaCompartilhavel ?? this.notaCompartilhavel,
        notaEstacao: notaEstacao ?? this.notaEstacao,
        notaGeral: notaGeral ?? this.notaGeral,
        notaOcasiao: notaOcasiao ?? this.notaOcasiao);
  }

  Map<String, Object?> toJson() {
    return {
      'nome': nome,
      'marca': marca,
      'notaCompartilhavel': notaCompartilhavel,
      'notaEstacao': notaEstacao,
      'notaGeral': notaGeral,
      'notaOcasiao': notaOcasiao,
    };
  }
}
