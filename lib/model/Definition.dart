class Definition {
  late String type;
  late String definition;
  late String example;

  Definition(
      {required this.type, required this.definition, required this.example});

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      type: json['type'] ?? '',
      definition: json['definition'] ?? '',
      example: json['example'] ?? '',
    );
  }
}
