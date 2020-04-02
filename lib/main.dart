import 'package:flutter/material.dart';
import 'home_page.dart';
import 'recipe.dart';
import 'random.dart';
import 'ingredients.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Demo',
      home: BottomNavigationBarController(),
    );
  }
}

class BottomNavigationBarController extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    HomePage(
      key: PageStorageKey('HomePage'),
    ),
    RecipePage(
      key: PageStorageKey('RecipePage'),
    ),
    IngredientsPage(
      key: PageStorageKey('IngredientsPage'),
    ),
    RandomPage(
      key: PageStorageKey('RecentPage'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index),
    currentIndex: selectedIndex,
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(
          icon: Icon(Icons.list), title: Text('Recipe')),
      BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart), title: Text('Ingredients')),
      BottomNavigationBarItem(
          icon: Icon(Icons.room_service), title: Text('Random')),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
