import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 93, 255)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <String>[];

  void goNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFav() {
    if (favorites.contains(current.asLowerCase)) {
      favorites.remove(current.asLowerCase);
    } else {
      favorites.add(current.asLowerCase);
    }
    notifyListeners();
  }

  void filterFav(String str) {
    if (favorites.contains(str)) {
      favorites.remove(str);

      notifyListeners();
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratePage();
        break;
      case 1:
        page = FavPage();
        break;
      default:
        page = Container();
        break;
    }

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text("Home")),
                NavigationRailDestination(icon: Icon(Icons.favorite), label: Text("Favorites")),
              ],
              onDestinationSelected: (destination) {
                setState(() {
                  selectedIndex = destination;
                  print(selectedIndex);
                });
              },
              selectedIndex: selectedIndex,
            ),
            Expanded(
              child: Container(
                child: page,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GeneratePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair.asLowerCase)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('A random idea:'),
              SizedBox(
                height: 20,
              ),
              BigCard(pair: pair),
              SizedBox(
                height: 20,
              ),
              Row(
                spacing: 16,
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFav();
                    },
                    label: Text('Favorite'),
                    icon: Icon(icon),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appState.goNext();
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    var favs = state.favorites;

    Widget header = Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          SizedBox(
            width: 8,
          ),
          Text("My Favorites", style: TextStyle(color: Colors.red, fontSize: 20))
        ],
      ),
    );

    List<Widget> favList = favs.asMap().entries.map((fav) {
      int index = fav.key;
      var value = fav.value;

      return Dismissible(
        direction: DismissDirection.startToEnd,
        key: Key(index.toString()),
        confirmDismiss: (direction) async {
          state.filterFav(value);
          return true;
        },
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              state.filterFav(value);
            },
            child: Icon(Icons.favorite, color: Colors.red[400]),
          ),
          title: Text(value),
        ),
      );
    }).toList();

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [header, if (favList.isEmpty) NoFavorites() else ...favList],
      ),
    );
  }
}

class NoFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget text = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(
          Icons.close,
          color: Colors.red[700],
        ),
        Text("No Favorites Available"),
        Icon(
          Icons.close,
          color: Colors.red[700],
        ),
      ],
    );

    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: 1),
      tween: Tween(begin: 1, end: 1.1),
      curve: Curves.easeInExpo,
      builder: (context, value, child) {
        return (Transform.scale(
          scale: value,
          child: child,
        ));
      },
      onEnd: () {
        print('anim ended');
        // Reverse animation
        // Future.delayed(Duration(seconds: 3), () {
        //   Navigator.pushReplacement(
        //     context,
        //     PageRouteBuilder(
        //       pageBuilder: (context, animation, secondaryAnimation) => NoFavorites(),
        //       transitionDuration: Duration.zero,
        //     ),
        //   );
        // });
      },
      child: text,
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Dismissible(
      key: Key("item1"),
      confirmDismiss: (direction) async {
        print(direction);
        state.goNext();

        return false;
      },
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(pair.asLowerCase, style: style),
        ),
      ),
    );
  }
}
