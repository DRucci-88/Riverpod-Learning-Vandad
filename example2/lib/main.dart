import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

extension OptionalInfixAddtion<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

// void testIt() {
//   final int? int1 = 1;
//   final int? int2 = 1;
//   final result = int1 + int2;
// }

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;

  // void decrement() => state = state == null ? 1 : state - 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>((ref) {
  return Counter();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            final text = count == null ? 'Press the button' : count.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            child: const Text('Increment Counter'),
          ),
        ],
      ),
    );
  }
}
