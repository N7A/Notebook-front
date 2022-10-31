import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String mainListTitle = 'Maison';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
      home: HomePage(title: mainListTitle, child: const CheckList(items: ["test", "test2"])),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.child});

  final String title;

  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_editMode ? Icons.shopping_cart_outlined : Icons.edit),
            onPressed: _pushEditMode,
            tooltip: _editMode ? 'Mode courses' : 'Mode édition',
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: _pushOptions,
            tooltip: 'Options',
          ),
        ],
      ),
      body: widget.child
    );
  }

  void _pushEditMode() {
    _editMode = !_editMode;
  }

  void _pushOptions() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('"${widget.title}" list options'),
              ),
              body: ListView(children: <Widget>[]),
            );
          },
        )
    );
  }
}

class CheckList extends StatefulWidget {
  const CheckList({super.key, required this.items});

  final List<String> items;

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    final tiles = widget.items.map(
          (pair) {
        return ListTile(
          title: Text(
            pair.toLowerCase(),
            style: _biggerFont,
          ),
        );
      },
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList()
        : <Widget>[];

    return ListView(children: divided);
  }
}
