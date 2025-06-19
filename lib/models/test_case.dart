class TestCase {
  final bool passing;
  final String? outActual;
  final String outExpected;
  final String? stackTrace;
  final Map<String, dynamic> inputs;
  final Map<String, dynamic> signature;

  TestCase({
    required this.inputs,
    required this.passing,
    required this.signature,
    required this.outActual,
    required this.outExpected,
    this.stackTrace,
  });

  factory TestCase.fromJSON(Map<String, dynamic> json) {
    return TestCase.fromMap(json);
  }
  factory TestCase.fromMap(Map<String, dynamic> map) {
    return TestCase(
      passing: map['passing'] ?? false,
      inputs: map['inputs'] ?? {},
      outActual: map['outActual'].toString(),
      outExpected: map['outExpected'].toString(),
      signature: map['signature'] ?? {"parameters": []},
      stackTrace: map['stackTrace']?.toString(),
    );
  }
}
