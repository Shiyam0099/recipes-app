import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/recipe.dart';
import '../models/recepies.dart';

class CategoriesItemPage extends StatefulWidget {
  static const routeName = '/categories-items';

  final availableRecipes;

  CategoriesItemPage(this.availableRecipes);

  @override
  State<CategoriesItemPage> createState() => _CategoriesItemPageState();
}

class _CategoriesItemPageState extends State<CategoriesItemPage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final displayedRecipes = widget.availableRecipes
        .where((recipes) => recipes.categories.contains(categoryId) as bool)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return Recipe(
            id: displayedRecipes[index].id,
            imgUrl: displayedRecipes[index].imageUrl,
            title: displayedRecipes[index].title,
            duration: displayedRecipes[index].duration,
            complexity: displayedRecipes[index].complexity,
            affordability: displayedRecipes[index].affordability,
          );
        }),
        itemCount: displayedRecipes.length,
      ),
    );
  }
}
