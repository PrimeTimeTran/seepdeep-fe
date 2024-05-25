import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'bloc/bloc_counter.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({super.key});

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterBloc(),
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(300),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bloc State',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Count:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(50),
                            Text(
                              state.count.toString(),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Updates:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(50),
                            Text(
                              state.updates.toString(),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Resets:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(50),
                            Text(
                              state.resets.toString(),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                            context
                                .read<CounterBloc>()
                                .add(CounterDecrementPressed());
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
                            context
                                .read<CounterBloc>()
                                .add(CounterIncrementPressed());
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
                            context
                                .read<CounterBloc>()
                                .add(CounterResetPressed());
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
