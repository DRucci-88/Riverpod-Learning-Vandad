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

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry'
];

final tickerProvider = StreamProvider((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (computationCount) {
      return computationCount + 1;
    },
  );
});

final namesProvider = StreamProvider((ref) {
  return ref.watch(tickerProvider.stream).map((event) {
    return names.getRange(0, event);
  });
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    final colors = <String>['red', 'green', 'blue', 'orange', 'pink'];
    final firstRange = colors.getRange(0, 3);
    print(firstRange.join(', '));
    firstRange.map((e) => print(e));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: names.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              print(data);
              return ListTile(title: Text(data.elementAt(index)));
            },
          );
        },
        error: (error, stackTrace) {
          return const Text('Reached the end of the list');
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
