import 'package:flutter/material.dart';
import '../pages/filter_page.dart';

class MainDrawer extends StatelessWidget {
  Widget drawerItems(IconData icon, String text, Function selectedItemPage) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w700,
            fontSize: 24),
      ),
      onTap: selectedItemPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            child: Text(
              'Cooking Time!',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          drawerItems(Icons.restaurant, 'Recepies', () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          drawerItems(Icons.filter_list, 'Filters', () {
            Navigator.of(context).pushReplacementNamed(FilterPage.routeName);
          })
        ],
      ),
    );
  }
}
