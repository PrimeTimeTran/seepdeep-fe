import 'package:app/screens/test_screen/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'repository/bloc_app.dart';
import 'repository/get_it.dart';

class NavigationFooter extends StatelessWidget {
  const NavigationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        debugPrint('State: $state');
      },
      builder: (context, state) {
        final provider = getIt.get<Repository>().appProvider;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Elsewhere'),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('isAuthenticated'),
                        const Gap(20),
                        SizedBox(
                          width: 50,
                          child: Text(
                            provider.isAuthenticated().toString(),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('isDarkMode'),
                        const Gap(20),
                        SizedBox(
                          width: 50,
                          child: Text(
                            provider.isDarkMode().toString(),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}

class ProviderWrapper extends StatefulWidget {
  const ProviderWrapper({super.key});

  @override
  State<ProviderWrapper> createState() => _ProviderWrapperState();
}

class RepositoryScreen extends StatefulWidget {
  const RepositoryScreen({super.key});

  @override
  State<RepositoryScreen> createState() => _RepositoryScreenState();
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _ProviderWrapperState extends State<ProviderWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<AppBloc>(),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RepositoryScreen(),
          NavigationFooter(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupDependencies();
  }
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  late final Repository _repository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext blocContext, state) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'isAuthenticated:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Gap(50),
                        Text(
                          state.isAuthenticated.toString(),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'isDarkMode:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Gap(50),
                        Text(
                          state.isDarkMode.toString(),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildAuthOptions(state),
                  const Gap(20),
                  SizedBox(
                    width: 200,
                    height: 75,
                    child: ElevatedButton(
                      onPressed: () {
                        _repository.appProvider.toggleTheme();
                      },
                      child: const Text('Toggle theme'),
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  Widget buildAuthOptions(state) {
    return SizedBox(
      width: 200,
      height: 75,
      child: ElevatedButton(
        onPressed: () {
          if (state.isAuthenticated) {
            _repository.signOut();
          } else {
            _repository.signIn();
          }
        },
        child: Text(state.isAuthenticated ? 'Sign Out' : 'Sign In'),
      ),
    );
  }

  @override
  void initState() {
    _repository = getIt.get<Repository>();
    super.initState();
  }
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return const ProviderWrapper();
  }
}
