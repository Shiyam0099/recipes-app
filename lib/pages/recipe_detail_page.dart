import 'package:flutter/material.dart';
import '../dummy_data.dart';

class RecipeDetailPage extends StatelessWidget {
  static const routeName = '/recipe-detail';
  final Function isFavorite;
  final Function toggleFavorite;

  RecipeDetailPage(this.isFavorite, this.toggleFavorite);

  Widget containerBilder(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget listContainerBuilder(
      Widget listview, MediaQueryData mediaQuery, bool isLandscape) {
    return Container(
        height: isLandscape
            ? mediaQuery.size.height * .55
            : mediaQuery.size.height * 0.30,
        width: mediaQuery.size.width * 0.8,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: listview);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final recipeId = ModalRoute.of(context).settings.arguments as String;

    final selectedRecipe =
        DUMMY_RECEPIES.firstWhere((recipe) => recipe.id == recipeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRecipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: isLandscape
                  ? mediaQuery.size.height * .65
                  : mediaQuery.size.height * 0.37,
              width: double.infinity,
              child: Image.network(
                selectedRecipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            containerBilder('Ingredients'),
            listContainerBuilder(
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(selectedRecipe.ingredients[index])),
                    );
                  },
                  itemCount: selectedRecipe.ingredients.length,
                ),
                mediaQuery,
                isLandscape),
            containerBilder('Steps'),
            listContainerBuilder(
              ListView.builder(
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            selectedRecipe.steps[index],
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 15),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }),
                itemCount: selectedRecipe.steps.length,
              ),
              mediaQuery,
              isLandscape,
            ),
            SizedBox(
              height: mediaQuery.size.height * .07,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            isFavorite(recipeId) ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: () => toggleFavorite(recipeId),
      ),
    );
  }
}
