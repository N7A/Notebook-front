import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  final String mainListTitle = 'Maison';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
      home: CheckListPage(title: mainListTitle, items: ["test", "test2"]),
    );
  }
}

class CheckListPage extends StatefulWidget {
  const CheckListPage({super.key, required this.title, required this.items});

  final String title;

  final List<String> items;

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  bool _editMode = false;

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    final items = widget.items.map(
          (label) {
            if (_editMode) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: label,
                    decoration: InputDecoration(
                      labelText: label.isEmpty ? 'New item' : '',
                    ),
                  )
              );
            } else {
              return Item(title: label.toLowerCase());
            }
      },
    );

    final divided = items.isNotEmpty
        ? ListTile.divideTiles(
      context: context,
      tiles: items,
    ).toList()
        : <Widget>[];

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
        body: ListView(children: divided)
    );
  }

  void _pushEditMode() {
    // rafraichissement de l'affichage
    setState(() {
      // changement de mode
      _editMode = !_editMode;
    });
  }

  void _pushOptions() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('"${widget.title}" list options'),
              ),
              body: ListView(children: List.empty()),
            );
          },
        )
    );
  }
}

class Item extends StatefulWidget {
  const Item({super.key, required this.title});

  final String title;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  final _biggerFont = const TextStyle(fontSize: 18);

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
      return CheckboxListTile(
        title: Text(widget.title, style: _biggerFont),
        value: _isSelected,
        onChanged: (bool? newValue) {
          setState(() {
            _isSelected = newValue!;
          });
        },
      );
    }
}
