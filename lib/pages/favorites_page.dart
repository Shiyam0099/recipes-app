import 'package:flutter/material.dart';
import '../models/recepies.dart';
import '../widgets/recipe.dart';

class FavoritesPage extends StatelessWidget {
  final List<Recepies> favoriteRecipes;

  FavoritesPage(this.favoriteRecipes);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: favoriteRecipes.isEmpty
          ? Text('No favorite items added yet!')
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Recipe(
                  id: favoriteRecipes[index].id,
                  imgUrl: favoriteRecipes[index].imageUrl,
                  title: favoriteRecipes[index].title,
                  duration: favoriteRecipes[index].duration,
                  complexity: favoriteRecipes[index].complexity,
                  affordability: favoriteRecipes[index].affordability,
                );
              }),
              itemCount: favoriteRecipes.length,
            ),
    );
  }
}
