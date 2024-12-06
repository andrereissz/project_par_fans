class PerfumeReview {
  String name;
  String brand;
  String reviewerId;
  String reviewerUsername;
  String notaCompartilhavel;
  String notaEstacao;
  int notaGeral;
  String notaOcasiao;

  PerfumeReview({
    required this.name,
    required this.brand,
    required this.notaCompartilhavel,
    required this.notaEstacao,
    required this.notaGeral,
    required this.notaOcasiao,
    required this.reviewerId,
    required this.reviewerUsername,
  });

  PerfumeReview.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          brand: json['brand']! as String,
          reviewerId: json['reviewerId']! as String,
          reviewerUsername: json['reviewerUsername']! as String,
          notaCompartilhavel: json['notaCompartilhavel']! as String,
          notaEstacao: json['notaEstacao']! as String,
          notaGeral: json['notaGeral']! as int,
          notaOcasiao: json['notaOcasiao']! as String,
        );

  PerfumeReview copyWith({
    String? name,
    String? brand,
    String? reviewerId,
    String? reviewerUsername,
    String? notaCompartilhavel,
    String? notaEstacao,
    int? notaGeral,
    String? notaOcasiao,
  }) {
    return PerfumeReview(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      reviewerId: reviewerId ?? this.reviewerId,
      reviewerUsername: reviewerUsername ?? this.reviewerUsername,
      notaCompartilhavel: notaCompartilhavel ?? this.notaCompartilhavel,
      notaEstacao: notaEstacao ?? this.notaEstacao,
      notaGeral: notaGeral ?? this.notaGeral,
      notaOcasiao: notaOcasiao ?? this.notaOcasiao,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'brand': brand,
      'reviewerId': reviewerId,
      'reviewerUsername': reviewerUsername,
      'notaCompartilhavel': notaCompartilhavel,
      'notaEstacao': notaEstacao,
      'notaGeral': notaGeral,
      'notaOcasiao': notaOcasiao,
    };
  }

  factory PerfumeReview.fromMap(Map<String, dynamic> data) {
    return PerfumeReview(
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      reviewerId: data['reviewerId'] ?? '',
      reviewerUsername: data['reviewerUsername'] ?? '',
      notaCompartilhavel: data['notaCompartilhavel'] ?? '',
      notaEstacao: data['notaEstacao'] ?? '',
      notaGeral: data['notaGeral'] ?? 0,
      notaOcasiao: data['notaOcasiao'] ?? '',
    );
  }
}
