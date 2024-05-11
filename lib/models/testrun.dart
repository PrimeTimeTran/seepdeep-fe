class TestCase {
  final bool passing;
  final List<dynamic> input;
  final String? outActual;
  final String outExpected;
  final Map<String, dynamic> signature;

  TestCase({
    required this.input,
    required this.passing,
    required this.signature,
    required this.outActual,
    required this.outExpected,
  });

  factory TestCase.fromJSON(Map<String, dynamic> json) {
    return TestCase.fromMap(json);
  }
  factory TestCase.fromMap(Map<String, dynamic> map) {
    return TestCase(
      passing: map['passing'] ?? false,
      input: map['input'] ?? [].toString(),
      outActual: map['outActual'].toString(),
      outExpected: map['outExpected'].toString(),
      signature: map['signature'] ?? {"parameters": []},
    );
  }
}
