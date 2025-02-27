import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/state/main.dart';
import 'package:provider/provider.dart' as legacyProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider).toString();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MaterialApp(
          title: 'Namer App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 93, 255)),
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text("App bar title"),
            ),
            body: Container(
                alignment: Alignment.center,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 2,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          onPressed: () {
                            ref.read(helloWorldProvider.notifier).state++;
                          },
                          label: const Text("Add"),
                          icon: const Icon(Icons.add)),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 2,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            ref.read(helloWorldProvider.notifier).state--;
                          },
                          label: const Text(
                            "Remove",
                          ),
                          icon: const Icon(Icons.remove)),
                    ),
                    Text(ref.watch(selfProvider).login.toString()),
                    ElevatedButton.icon(
                        onPressed: () {
                          ref.read(selfProvider.notifier).update(login: true);
                        },
                        label: Text("login"),
                        icon: Icon(Icons.login)),
                    ElevatedButton.icon(
                        onPressed: () {
                          ref.read(selfProvider.notifier).update(login: false);
                        },
                        label: Text("login"),
                        icon: Icon(Icons.login)),
                  ],
                )),
          ),
        );
      },
    );
  }
}

// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();
//   var favorites = <String>[];

//   void goNext() {
//     current = WordPair.random();
//     notifyListeners();
//   }

//   void toggleFav() {
//     if (favorites.contains(current.asLowerCase)) {
//       favorites.remove(current.asLowerCase);
//     } else {
//       favorites.add(current.asLowerCase);
//     }
//     notifyListeners();
//   }

//   void filterFav(String str) {
//     if (favorites.contains(str)) {
//       favorites.remove(str);

//       notifyListeners();
//     }
//   }
// }
