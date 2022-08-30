import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sigma/modules/riverpod_counter/pages/riverpod_counter_home_page.dart';

class RiverpodCounterPage extends ConsumerWidget {
  const RiverpodCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(counterProvider);

    final AsyncValue<int> countStream = ref.watch(counterStreamProvider(30));

    ref.listen<int>(
      counterProvider,
      (previous, next) {
        if (next >= 5) {
          // Do Something
        }
      },
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
      ),
      appBar: AppBar(
        title: const Text("Riverpod Counter"),
        actions: [
          IconButton(
              onPressed: () {
                ref.invalidate(counterProvider);

                //* Can use [ref.refresh(counterProvider)] it returns counter value,
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            counter.toString(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 20),
          Text(
            "Count Stream : ${countStream.when(
              data: (int value) => value,
              error: (error, stackTrace) {},
              loading: () {},
            )}",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      )),
    );
  }
}
