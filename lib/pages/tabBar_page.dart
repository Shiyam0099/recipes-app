import 'package:flutter/material.dart';
import '../models/recepies.dart';
import '../widgets/main_drawer.dart';
import './categories_page.dart';
import './favorites_page.dart';

class TabsPage extends StatefulWidget {
  final List<Recepies> favoriteRecipes;

  TabsPage(this.favoriteRecipes);
  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': Categories(), 'title': 'Categories'},
      {
        'page': FavoritesPage(widget.favoriteRecipes),
        'title': 'Your Favorites'
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//     return DefaultTabController(    //default or appBar's or top TabBar
//       initialIndex: 0,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Recepies'),
//           bottom: TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Categories',
//               ),
//               Tab(icon: Icon(Icons.star), text: 'Favorites'),
//             ],
//           ),
//         ),
//         body: TabBarView(children: [Categories(), FavoritesPage()]),
//       ),
//     );

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: _selectedPage,
      ),
    );
  }
}
