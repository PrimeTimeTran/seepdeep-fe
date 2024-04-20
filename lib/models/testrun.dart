class TestRun {
  final int idx;
  final String outputActual;
  final String outputExpected;
  final bool passing;

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
      outputActual: map['outputActual'],
      outputExpected: map['outputExpected'],
      passing: map['passing'],
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
