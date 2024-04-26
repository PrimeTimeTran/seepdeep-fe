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
