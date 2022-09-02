import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/recepies.dart';
import './pages/filter_page.dart';
import './pages/recipe_detail_page.dart';
import './pages/categories_items_page.dart';
import './pages/tabBar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten-free': false,
    'lactose-free': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Recepies> availableRecipes = DUMMY_RECEPIES;
  List<Recepies> favoriteRecipes = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      availableRecipes = DUMMY_RECEPIES.where((recipes) {
        if (_filters['gluten-free'] && !recipes.isGlutenFree) {
          return false;
        }
        if (_filters['lactose-free'] && !recipes.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !recipes.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !recipes.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String recipeId) {
    final existingIndex = favoriteRecipes.indexWhere(
      (recipes) => recipeId == recipes.id,
    );
    if (existingIndex >= 0) {
      setState(() {
        favoriteRecipes.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteRecipes.add(
            DUMMY_RECEPIES.firstWhere((recipes) => recipeId == recipes.id));
      });
    }
  }

  bool _isFavorite(String recipeId) {
    return favoriteRecipes.any((element) => element.id == recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline6: TextStyle(fontSize: 18, fontFamily: 'Raleway'))),
        // theme: ThemeData.dark(),
        routes: {
          '/': (context) => TabsPage(favoriteRecipes),
          CategoriesItemPage.routeName: (context) =>
              CategoriesItemPage(availableRecipes),
          RecipeDetailPage.routeName: (context) =>
              RecipeDetailPage(_isFavorite, _toggleFavorites),
          FilterPage.routeName: (context) => FilterPage(_filters, _setFilters),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: ((context) => CategoriesItemPage(availableRecipes)));
        });
  }
}
