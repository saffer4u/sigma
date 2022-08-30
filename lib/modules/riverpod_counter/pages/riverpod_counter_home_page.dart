import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sigma/modules/riverpod_counter/riverpod_counter_module.dart';

// Use this insted to autoDispose state if you [push/pop];
// final counterProvider = StateProvider.autoDispose((ref) => 0);

final counterProvider = StateProvider((ref) => 0);

final counterStreamProvider = StreamProvider.autoDispose.family<int, int>(
  (ref, start) {
    final wsClint = ref.watch(websocketClientProvider);

    return wsClint.getCounterStream(start);
  },
);

abstract class WebsocketClient {
  Stream<int> getCounterStream([int i]);
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      yield i++;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}

final websocketClientProvider = Provider<WebsocketClient>(
  (ref) {
    return FakeWebsocketClient();
  },
);

class RiverpodCounterHomePage extends StatelessWidget {
  const RiverpodCounterHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Counter Home"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Counter Page'),
          onPressed: () {
            Modular.to.pushNamed(RiverpodCounterModuleRoutes.getRoute(
                RiverpodCounterModuleRoutes.riverpodCounterPage));
          },
        ),
      ),
    );
  }
}
