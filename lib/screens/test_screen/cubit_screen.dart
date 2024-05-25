import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void decrement() => emit(state - 1);
  void increment() => emit(state + 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  void reset() => emit(0);
}

class CubitScreen extends StatefulWidget {
  const CubitScreen({super.key});

  @override
  State<CubitScreen> createState() => _CubitScreenState();
}

class _CubitScreenState extends State<CubitScreen> {
  final cubitA = CounterCubit();
  final cubitB = CounterCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {
      return CounterCubit();
    }, child: BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(300),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cubit State',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  state.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const Gap(20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 75,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CounterCubit>().decrement();
                        },
                        child: const Text('Decrement'),
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: 200,
                      height: 75,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CounterCubit>().increment();
                        },
                        child: const Text('Increment'),
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                        width: 200,
                        height: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CounterCubit>().reset();
                          },
                          child: const Text('Reset'),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
