import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int count;
  final int updates;
  final int resets;

  const CounterState(this.count, this.updates, this.resets);

  @override
  List<Object?> get props => [count, updates, resets];
}
