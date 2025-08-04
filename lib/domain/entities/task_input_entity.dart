class TaskInputEntity {
  final String inputText;

  TaskInputEntity({required this.inputText});

  Map<String, dynamic> toJson() => {
    "input": inputText
  };
}