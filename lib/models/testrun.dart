class TestCase {
  final int idx;
  final bool passing;
  final List input;
  final String? outputActual;
  final String outputExpected;
  final Map<String, dynamic> signature;

  // Constructor
  TestCase({
    required this.idx,
    required this.input,
    required this.passing,
    required this.signature,
    required this.outputActual,
    required this.outputExpected,
  });

  // Factory constructor to create an instance from a map
  factory TestCase.fromMap(Map<String, dynamic> map) {
    return TestCase(
      idx: map['idx'] ?? 0,
      signature: map['signature'] ?? {"parameters": []},
      passing: map['passing'] ?? false,
      outputActual: map['outputActual'],
      outputExpected: map['outputExpected'],
      input: map['input'] ?? [].toString(),
    );
  }
  factory TestCase.placeholder() {
    return TestCase(
      idx: 0,
      input: [],
      passing: false,
      signature: {},
      outputActual: '[]',
      outputExpected: '[]',
    );
  }
}

class TestRun {
  final int idx;
  final bool passing;
  final String outputActual;
  final String outputExpected;

  // Constructor
  TestRun({
    required this.idx,
    required this.passing,
    required this.outputActual,
    required this.outputExpected,
  });

  // Factory constructor to create an instance from a map
  factory TestRun.fromMap(Map<String, dynamic> map) {
    return TestRun(
      idx: map['idx'],
      passing: map['passing'],
      outputActual: map['outputActual'],
      outputExpected: map['outputExpected'],
    );
  }
  factory TestRun.placeholder() {
    return TestRun(
      idx: 0,
      outputActual: '[]',
      outputExpected: '[]',
      passing: false,
    );
  }
}
